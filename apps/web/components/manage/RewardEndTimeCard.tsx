"use client";

import { useState, useEffect } from "react";
import { ChevronDown } from "lucide-react";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { Card } from "@/components/ui/card";
import { Label } from "@/components/ui/label";
import { Calendar } from "@/components/ui/calendar";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

import { useSetRewardEndTime } from "@/hooks/contracts/useStaking";

export default function RewardEndTimeCard() {
  const [date, setDate] = useState<Date | undefined>(new Date());
  const [open, setOpen] = useState(false);
  const [time, setTime] = useState<string>(() => {
    const now = new Date();
    return `${now.getHours().toString().padStart(2, "0")}:${now.getMinutes().toString().padStart(2, "0")}`;
  });

  const { updateEndTime, isLoading, isConfirmed, hash, error } =
    useSetRewardEndTime();

  useEffect(() => {
    if (isConfirmed) {
      console.log("Reward end time updated successfully!", hash);
    }
  }, [isConfirmed, hash]);

  useEffect(() => {
    if (error) {
      console.error("Error updating reward end time:", error);
    }
  }, [error]);

  useEffect(() => {
    if (isLoading) {
      console.log("Transaction is being processed...");
    }
  });

  const onUpdateEndTime = async () => {
    if (!date) return;

    const unix = Math.floor(date.getTime() / 1000);
    console.log("FINAL Unix Timestamp:", unix);

    try {
      await updateEndTime(unix);

      console.log("Transaction submitted successfully");
    } catch (error) {
      console.log("Transaction rejected or failed", error);
    }
  };

  const handleDateSelect = (selectedDate: Date | undefined) => {
    if (!selectedDate) return;

    const [hours, minutes] = time.split(":").map(Number);

    selectedDate.setHours(hours || 0);
    selectedDate.setMinutes(minutes || 0);

    setDate(selectedDate);
  };

  const handleTimeChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const newTime = e.target.value;
    setTime(newTime);

    if (date) {
      const [hours, minutes] = newTime.split(":").map(Number);

      const newDate = new Date(date);
      newDate.setHours(hours);
      newDate.setMinutes(minutes);

      setDate(newDate);
    }
  };

  return (
    <Card className="p-6 border border-border bg-card">
      <h3 className="text-lg font-semibold text-foreground mb-4">
        Update End Time
      </h3>
      <div className="space-y-4">
        <div>
          <div className="flex gap-4 mt-2">
            <div className="flex flex-col gap-3">
              <Label htmlFor="date-picker" className="px-1">
                Date
              </Label>
              <Popover open={open} onOpenChange={setOpen}>
                <PopoverTrigger asChild>
                  <Button
                    variant="outline"
                    id="date-picker"
                    className="w-32 justify-between font-normal"
                  >
                    {date ? date.toLocaleDateString() : "Select date"}
                    <ChevronDown className="h-4 w-4 opacity-50" />
                  </Button>
                </PopoverTrigger>
                <PopoverContent
                  className="w-auto overflow-hidden p-0"
                  align="start"
                >
                  <Calendar
                    mode="single"
                    selected={date}
                    captionLayout="dropdown"
                    onSelect={handleDateSelect}
                  />
                </PopoverContent>
              </Popover>
            </div>

            <div className="flex flex-col gap-3">
              <Label htmlFor="time-picker" className="px-1">
                Time
              </Label>
              <Input
                type="time"
                id="time-picker"
                step="60"
                value={time}
                onChange={handleTimeChange}
                className="bg-background w-32"
              />
            </div>
          </div>

          <p className="text-xs text-muted-foreground mt-4">
            Current Selection: {date ? date.toLocaleString() : "None"}
          </p>
        </div>

        <Button className="w-full" variant="outline" onClick={onUpdateEndTime}>
          Update End Time
        </Button>
      </div>
    </Card>
  );
}
