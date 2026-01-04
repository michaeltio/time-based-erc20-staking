export default function Footer() {
  return (
    <footer className="w-full py-4 border-t mt-8 text-center text-sm text-gray-500 bg-zinc-950">
      &copy; {new Date().getFullYear()} Time-Based ERC20 Staking. All rights
      reserved.
    </footer>
  );
}
