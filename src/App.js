import React from 'react';

function App() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 flex items-center justify-center">
      <div className="max-w-4xl mx-auto px-6 text-center">
        <div className="bg-white rounded-2xl shadow-2xl p-12 transform hover:scale-105 transition-transform duration-300">
          <h1 className="text-6xl font-bold text-gray-800 mb-6">
            David Vizena
          </h1>
          <p className="text-xl text-gray-600 mb-8">
            Welcome to my portfolio project! This is a simple Hello World application
            built with React, Tailwind CSS, Docker, and deployed on Kubernetes.
          </p>
          <div className="flex justify-center space-x-4">
            <div className="bg-blue-100 text-blue-800 px-4 py-2 rounded-full text-sm font-medium">
              React
            </div>
            <div className="bg-green-100 text-green-800 px-4 py-2 rounded-full text-sm font-medium">
              Tailwind CSS
            </div>
            <div className="bg-orange-100 text-orange-800 px-4 py-2 rounded-full text-sm font-medium">
              Docker
            </div>
            <div className="bg-purple-100 text-purple-800 px-4 py-2 rounded-full text-sm font-medium">
              Kubernetes
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;
