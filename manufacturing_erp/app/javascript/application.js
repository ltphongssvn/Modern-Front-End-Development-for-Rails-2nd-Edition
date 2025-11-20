// manufacturing_erp/app/javascript/application.js
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// React component mounting
import React from 'react';
import ReactDOM from 'react-dom/client';
import FactoryFloorVisualization from './components/FactoryFloorVisualization';

document.addEventListener('DOMContentLoaded', () => {
  const factoryFloorElement = document.getElementById('factory-floor-visualization');
  if (factoryFloorElement) {
    const root = ReactDOM.createRoot(factoryFloorElement);
    root.render(<FactoryFloorVisualization />);
  }
});
