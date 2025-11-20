// manufacturing_erp/app/javascript/components/ProductionScheduleGantt.tsx
import React, { useEffect, useState } from 'react';

interface ScheduleItem {
  id: number;
  equipment: string;
  task: string;
  startTime: Date;
  endTime: Date;
  status: 'scheduled' | 'in-progress' | 'completed';
}

const ProductionScheduleGantt: React.FC = () => {
  const [scheduleItems, setScheduleItems] = useState<ScheduleItem[]>([]);
  const hours = Array.from({ length: 24 }, (_, i) => i);

  useEffect(() => {
    // Mock data - replace with API call
    setScheduleItems([
      {
        id: 1,
        equipment: 'CNC Machine A1',
        task: 'Part Production Batch #451',
        startTime: new Date(2024, 0, 1, 8, 0),
        endTime: new Date(2024, 0, 1, 12, 0),
        status: 'in-progress'
      },
      {
        id: 2,
        equipment: 'Robotic Arm A2',
        task: 'Assembly Line Support',
        startTime: new Date(2024, 0, 1, 9, 0),
        endTime: new Date(2024, 0, 1, 17, 0),
        status: 'scheduled'
      },
      {
        id: 3,
        equipment: 'CNC Machine B1',
        task: 'Maintenance',
        startTime: new Date(2024, 0, 1, 14, 0),
        endTime: new Date(2024, 0, 1, 16, 0),
        status: 'scheduled'
      }
    ]);
  }, []);

  const getBarPosition = (item: ScheduleItem) => {
    const startHour = item.startTime.getHours();
    const duration = (item.endTime.getTime() - item.startTime.getTime()) / (1000 * 60 * 60);
    return {
      left: `${(startHour / 24) * 100}%`,
      width: `${(duration / 24) * 100}%`
    };
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'in-progress': return 'bg-blue-500';
      case 'completed': return 'bg-green-500';
      default: return 'bg-gray-400';
    }
  };

  return (
    <div className="p-6 bg-white rounded-lg shadow">
      <h2 className="text-xl font-bold mb-4">Production Schedule</h2>
      <div className="overflow-x-auto">
        <div className="min-w-[800px]">
          {/* Time header */}
          <div className="flex border-b-2 mb-2 text-xs">
            {hours.map(hour => (
              <div key={hour} className="flex-1 text-center py-1 border-r">
                {hour}:00
              </div>
            ))}
          </div>
          
          {/* Gantt rows */}
          {scheduleItems.map(item => (
            <div key={item.id} className="flex items-center mb-2 h-12 relative">
              <div className="w-32 pr-2 text-sm font-medium truncate">
                {item.equipment}
              </div>
              <div className="flex-1 relative h-8 bg-gray-100 rounded">
                <div
                  className={`absolute h-full rounded ${getStatusColor(item.status)} text-white text-xs flex items-center px-2`}
                  style={getBarPosition(item)}
                >
                  <span className="truncate">{item.task}</span>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
      
      {/* Legend */}
      <div className="flex gap-4 mt-4 text-sm">
        <div className="flex items-center">
          <div className="w-4 h-4 bg-blue-500 rounded mr-2"></div>
          In Progress
        </div>
        <div className="flex items-center">
          <div className="w-4 h-4 bg-gray-400 rounded mr-2"></div>
          Scheduled
        </div>
        <div className="flex items-center">
          <div className="w-4 h-4 bg-green-500 rounded mr-2"></div>
          Completed
        </div>
      </div>
    </div>
  );
};

export default ProductionScheduleGantt;
