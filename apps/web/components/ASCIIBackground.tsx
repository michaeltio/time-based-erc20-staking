"use client";

import { useEffect, useRef } from "react";
import * as THREE from "three";
import { AsciiEffect } from "three/examples/jsm/effects/AsciiEffect.js";

export default function AsciiBackground() {
  const mountRef = useRef<HTMLDivElement | null>(null);

  useEffect(() => {
    if (!mountRef.current) return;

    // ===== Scene =====
    const scene = new THREE.Scene();
    scene.background = new THREE.Color("#020617");

    // ===== Camera (ORTHO FULL SCREEN) =====
    const camera = new THREE.OrthographicCamera();
    camera.position.z = 10;

    // ===== Renderer =====
    const renderer = new THREE.WebGLRenderer();
    renderer.setSize(window.innerWidth, window.innerHeight);

    // ===== ASCII Effect =====
    const effect = new AsciiEffect(renderer, " .:-=+*#%@", {
      invert: true,
    });

    effect.domElement.style.color = "#525252ff";
    effect.domElement.style.backgroundColor = "#020617";
    effect.domElement.style.position = "fixed";
    effect.domElement.style.inset = "0";
    effect.domElement.style.pointerEvents = "none";
    effect.domElement.style.zIndex = "-1";

    mountRef.current.appendChild(effect.domElement);

    // ===== Geometry (akan di-scale sesuai screen) =====
    let geometry: THREE.PlaneGeometry;
    const material = new THREE.MeshBasicMaterial({
      color: 0xffffff,
      wireframe: true,
    });

    const plane = new THREE.Mesh(undefined as any, material);
    plane.rotation.x = Math.PI / 6;
    scene.add(plane);

    // ===== Resize & Setup =====
    const setup = () => {
      const width = window.innerWidth;
      const height = window.innerHeight;
      const aspect = width / height;

      // Ortho camera mengikuti screen
      const viewSize = 10;
      camera.left = (-aspect * viewSize) / 2;
      camera.right = (aspect * viewSize) / 2;
      camera.top = viewSize / 2;
      camera.bottom = -viewSize / 2;
      camera.near = 0.1;
      camera.far = 50;
      camera.updateProjectionMatrix();

      // Geometry mengikuti layar
      geometry?.dispose();
      geometry = new THREE.PlaneGeometry(
        aspect * viewSize,
        viewSize,
        Math.floor(width / 6), // density mengikuti screen
        Math.floor(height / 20)
      );

      plane.geometry = geometry;

      renderer.setSize(width, height);
      effect.setSize(width, height);
    };

    setup();
    window.addEventListener("resize", setup);

    // ===== Animation =====
    let time = 0;
    let frameId: number;

    const animate = () => {
      time += 0.04;

      const pos = geometry.attributes.position as THREE.BufferAttribute;

      for (let i = 0; i < pos.count; i++) {
        const x = pos.getX(i);
        const d = Math.abs(x);

        const z = Math.sin(d * 2.5 - time * 2) * Math.exp(-d * 0.25) * 1.6;

        pos.setZ(i, z);
      }

      pos.needsUpdate = true;
      geometry.computeVertexNormals();

      effect.render(scene, camera);
      frameId = requestAnimationFrame(animate);
    };

    animate();

    // ===== Cleanup =====
    return () => {
      cancelAnimationFrame(frameId);
      window.removeEventListener("resize", setup);

      geometry.dispose();
      material.dispose();
      renderer.dispose();

      mountRef.current?.removeChild(effect.domElement);
    };
  }, []);

  return <div ref={mountRef} aria-hidden />;
}
