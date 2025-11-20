// manufacturing_erp/app/javascript/components/FactoryFloorVisualization.tsx
import React, { useEffect, useState } from 'react';

interface Equipment {
  id: number;
  name: string;
  status: 'operational' | 'maintenance' | 'offline';
  efficiency?: number;
}

interface ProductionLine {
  id: number;
  name: string;
  status: 'active' | 'inactive' | 'maintenance';
  capacity: number;
  currentOutput: number;
  efficiency: number;
  equipment: Equipment[];
}

const FactoryFloorVisualization: React.FC = () => {
  const [productionLines, setProductionLines] = useState<ProductionLine[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchProductionData();
    const interval = setInterval(fetchProductionData, 5000); // Refresh every 5 seconds
    return () => clearInterval(interval);
  }, []);

  const fetchProductionData = async () => {
    try {
      const response = await fetch('/api/production_lines');
      const data = await response.json();
      setProductionLines(data);
      setLoading(false);
    } catch (error) {
      console.error('Failed to fetch production data:', error);
      setLoading(false);
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'active':
      case 'operational':
        return 'bg-green-500';
      case 'maintenance':
        return 'bg-yellow-500';
      case 'inactive':
      case 'offline':
        return 'bg-red-500';
      default:
        return 'bg-gray-500';
    }
  };

  if (loading) return <div>Loading factory floor data...</div>;

  return (
    <div className="p-6 bg-gray-100 rounded-lg">
      <h2 className="text-2xl font-bold mb-6">Factory Floor Visualization</h2>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {productionLines.map((line) => (
          <div key={line.id} className="bg-white rounded-lg shadow-lg p-4">
            <div className="flex justify-between items-center mb-4">
              <h3 className="text-lg font-semibold">{line.name}</h3>
              <span className={`px-3 py-1 rounded text-white ${getStatusColor(line.status)}`}>
                {line.status.toUpperCase()}
              </span>
            </div>
            
            <div className="mb-4">
              <div className="flex justify-between text-sm mb-1">
                <span>Efficiency</span>
                <span>{line.efficiency}%</span>
              </div>
              <div className="w-full bg-gray-200 rounded-full h-2">
                <div 
                  className="bg-blue-600 h-2 rounded-full transition-all duration-500"
                  style={{ width: `${line.efficiency}%` }}
                />
              </div>
            </div>

            <div className="mb-4">
              <div className="flex justify-between text-sm mb-1">
                <span>Output</span>
                <span>{line.currentOutput} / {line.capacity}</span>
              </div>
              <div className="w-full bg-gray-200 rounded-full h-2">
                <div 
                  className="bg-green-600 h-2 rounded-full transition-all duration-500"
                  style={{ width: `${(line.currentOutput / line.capacity) * 100}%` }}
                />
              </div>
            </div>

            {line.equipment && line.equipment.length > 0 && (
              <div className="border-t pt-3">
                <h4 className="text-sm font-medium mb-2">Equipment Status</h4>
                <div className="flex flex-wrap gap-2">
                  {line.equipment.map((equip) => (
                    <div 
                      key={equip.id}
                      className={`w-8 h-8 rounded-full ${getStatusColor(equip.status)} 
                                  flex items-center justify-center text-white text-xs`}
                      title={`${equip.name}: ${equip.status}`}
                    >
                      {equip.name.charAt(0)}
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
        ))}
      </div>
    </div>
  );
};

export default FactoryFloorVisualization;
