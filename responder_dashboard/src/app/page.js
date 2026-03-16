"use client";
import React, { useState } from 'react';
import ResponderDashboard from '../components/ResponderDashboard';
import SystemAnalyticsDashboard from '../components/SystemAnalyticsDashboard';
import { ShieldAlert, BarChart3, Activity } from 'lucide-react';

export default function Home() {
  const [view, setView] = useState('responder'); // 'responder' or 'admin'

  return (
    <div className="flex flex-col h-screen overflow-hidden bg-slate-50 font-sans">
      {/* Top Navbar Switcher (For Demo purposes) */}
      <div className="bg-white border-b border-slate-200 px-8 py-3 flex justify-between items-center z-50 shadow-sm relative">
        <div className="flex items-center gap-3 font-black text-blue-900 tracking-tighter text-xl">
          <ShieldAlert size={28} className="text-blue-800" />
          <span>BTDCS PORTAL</span>
        </div>
        <div className="flex bg-slate-100 p-1.5 rounded-2xl border border-slate-200/50">
          <button
            onClick={() => setView('responder')}
            className={`flex items-center gap-2 px-6 py-2 rounded-xl text-xs font-bold transition-all duration-300 ${view === 'responder'
                ? 'bg-white shadow-md text-blue-800 ring-1 ring-slate-200/50'
                : 'text-slate-400 hover:text-slate-600'
              }`}
          >
            <Activity size={16} />
            Responder Feed
          </button>
          <button
            onClick={() => setView('admin')}
            className={`flex items-center gap-2 px-6 py-2 rounded-xl text-xs font-bold transition-all duration-300 ${view === 'admin'
                ? 'bg-white shadow-md text-blue-800 ring-1 ring-slate-200/50'
                : 'text-slate-400 hover:text-slate-600'
              }`}
          >
            <BarChart3 size={16} />
            System Admin
          </button>
        </div>
        <div className="flex items-center gap-4">
          <div className="flex flex-col items-end">
            <span className="text-[10px] font-black text-slate-300 uppercase tracking-[0.3em]">Version</span>
            <span className="text-[12px] font-mono font-bold text-slate-400">1.0.0-NEXT</span>
          </div>
          <div className="w-10 h-10 rounded-full bg-slate-100 border border-slate-200 flex items-center justify-center text-slate-400">
            <ShieldAlert size={18} />
          </div>
        </div>
      </div>

      <div className="flex-1 overflow-hidden">
        {view === 'responder' ? <ResponderDashboard /> : <SystemAnalyticsDashboard />}
      </div>
    </div>
  );
}
