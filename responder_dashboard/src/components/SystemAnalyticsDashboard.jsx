"use client";
import React from 'react';
import {
  TrendingUp,
  Timer,
  Server,
  Calendar,
  MoreVertical,
  ChevronRight,
  MapPin,
  ShieldCheck,
  Activity,
  History,
  PieChart,
  Bell,
  Settings,
  ShieldAlert,
  ArrowDown
} from 'lucide-react';
import { motion } from 'framer-motion';
import { supabase } from '../lib/supabase';
import { useState, useEffect } from 'react';

const SystemAnalyticsDashboard = () => {
  const [stats, setStats] = useState({
    total: 0,
    accepted: 0,
    avgResponse: "00:00",
    categories: { medical: 25, security: 30, other: 45 },
    weeklyTrends: [0, 0, 0, 0, 0, 0, 0]
  });

  useEffect(() => {
    const fetchAnalytics = async () => {
      const { data, error } = await supabase
        .from('emergency_alerts')
        .select('*');

      if (!error && data) {
        const total = data.length;
        const handledAlerts = data.filter(d => d.accepted_at != null);

        // Avg Response
        let avgResponse = "00:00";
        if (handledAlerts.length > 0) {
          const totalMs = handledAlerts.reduce((acc, curr) => acc + (new Date(curr.accepted_at) - new Date(curr.created_at)), 0);
          const avgSecs = (totalMs / handledAlerts.length) / 100;
          const mins = Math.floor(avgSecs / 60);
          const secs = Math.floor(avgSecs % 60);
          avgResponse = `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
        }

        // Weekly Trends
        const weeklyAlerts = new Array(7).fill(0);
        data.forEach(alert => {
          const day = new Date(alert.created_at).getDay();
          weeklyAlerts[day]++;
        });

        // Severity Distribution
        const critical = data.filter(d => d.severity === 'Critical').length;
        const high = data.filter(d => d.severity === 'High').length;
        const medium = data.filter(d => d.severity === 'Medium' || d.severity === 'Low').length;

        setStats({
          total,
          accepted: handledAlerts.length,
          avgResponse,
          weeklyTrends: weeklyAlerts,
          categories: {
            critical: Math.round((critical / total) * 100) || 0,
            high: Math.round((high / total) * 100) || 0,
            medium: Math.round((medium / total) * 100) || 0
          }
        });
      }
    };

    fetchAnalytics();
  }, []);

  return (
    <div className="flex h-screen bg-[#f5f5f5] text-slate-900">
      {/* Sidebar (Consistent with Responder view) */}
      <aside className="w-80 bg-white border-r border-gray-100 flex flex-col z-30 shadow-sm">
        <div className="p-8 border-b border-gray-50 flex items-center gap-4">
          <div className="size-12 bg-[#e4423a] rounded-2xl flex items-center justify-center text-white shadow-lg shadow-red-200">
            <ShieldAlert size={24} />
          </div>
          <div>
            <h1 className="font-black text-[#e4423a] text-lg tracking-tighter uppercase leading-none">Nile Univ.</h1>
            <p className="text-[10px] font-black text-gray-400 tracking-widest uppercase">Analytics</p>
          </div>
        </div>
        <nav className="flex-1 p-6 space-y-2">
          {/* We link back to ResponderDashboard parts if needed, but for now just NavItems */}
          <NavItem icon={<Activity />} label="Incident Feed" />
          <NavItem icon={<History />} label="Log History" />
          <NavItem icon={<PieChart />} label="Performance" active />
          <div className="pt-6 pb-2 text-[10px] font-black text-gray-400 uppercase tracking-widest ml-4">Management</div>
          <NavItem icon={<Settings />} label="Network Config" />
        </nav>
      </aside>

      {/* Main Workspace */}
      <main className="flex-1 flex flex-col overflow-hidden">
        <header className="h-20 bg-white border-b border-gray-100 px-8 flex items-center justify-between sticky top-0 z-20">
          <div className="flex items-center gap-3">
            <h2 className="text-xl font-black tracking-tight">System Performance</h2>
          </div>
          <button className="flex items-center gap-2 px-4 py-2 bg-gray-50 border border-gray-100 rounded-xl text-xs font-bold text-gray-600 hover:bg-gray-100 transition-all">
            <Calendar size={16} />
            <span>Last 7 Days</span>
          </button>
        </header>

        <div className="flex-1 overflow-y-auto p-10 space-y-10">
          {/* Metric Grid */}
          <div className="grid grid-cols-12 gap-8">
            <div className="col-span-12 lg:col-span-8 bg-white rounded-[40px] p-10 border border-gray-100 shadow-soft flex flex-col">
              <div className="flex justify-between items-start mb-8">
                <div>
                  <p className="text-xs font-black text-gray-400 uppercase tracking-widest mb-1">Total Emergency Signals</p>
                  <h3 className="text-6xl font-black tracking-tighter text-gray-900">{stats.total}</h3>
                </div>
                <div className="px-4 py-1.5 bg-red-50 text-red-600 rounded-full text-[10px] font-black border border-red-100 flex items-center gap-1">
                  <TrendingUp size={12} />
                  +12% TREND
                </div>
              </div>
              <p className="text-xs text-gray-400 font-bold mb-10">Live data synchronization active • vs 127 last week</p>

              {/* Chart Placeholder */}
              <div className="flex-1 bg-gray-50 rounded-3xl p-8 border border-gray-100 flex flex-col">
                <div className="flex justify-between items-center mb-6">
                  <h4 className="text-sm font-black text-gray-900 uppercase tracking-tight">Daily Incident Volume</h4>
                  <div className="flex gap-4">
                    <div className="flex items-center gap-2">
                      <div className="size-2 rounded-full bg-[#e4423a]" />
                      <span className="text-[10px] font-black text-gray-400 uppercase">Current</span>
                    </div>
                    <div className="flex items-center gap-2">
                      <div className="size-2 rounded-full bg-gray-300" />
                      <span className="text-[10px] font-black text-gray-400 uppercase">Baseline</span>
                    </div>
                  </div>
                </div>
                <div className="flex-1 flex items-end justify-between gap-4 px-2">
                  {stats.weeklyTrends.map((val, idx) => (
                    <div key={idx} className="flex-1 flex flex-col items-center gap-4 group">
                      <div
                        className="w-full bg-[#e4423a] rounded-t-xl transition-all duration-500 shadow-lg shadow-red-200 group-hover:bg-red-700"
                        style={{ height: `${(val / (Math.max(...stats.weeklyTrends) || 1)) * 100}%`, minHeight: '10%' }}
                      />
                      <span className="text-[9px] font-black text-gray-400 uppercase tracking-widest">
                        {['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'][idx]}
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            </div>

            <div className="col-span-12 lg:col-span-4 flex flex-col gap-8">
              <MetricCard
                label="Avg Response"
                value={stats.avgResponse}
                sub="30s BETTER"
                icon={<Timer size={24} className="text-blue-600" />}
                color="blue"
                trend="down"
              />
              <MetricCard
                label="System Uptime"
                value="99.9%"
                sub="STABLE"
                icon={<Server size={24} className="text-green-600" />}
                color="green"
                trend="up"
              />
            </div>
          </div>

          {/* Distribution & Locations */}
          <div className="grid grid-cols-12 gap-8 pb-10">
            <div className="col-span-12 lg:col-span-4 bg-white rounded-[40px] p-10 border border-gray-100 shadow-soft">
              <h4 className="text-lg font-black tracking-tight mb-2">Priority Balance</h4>
              <p className="text-xs font-bold text-gray-400 uppercase tracking-widest mb-10">Severity Breakdown</p>

              <div className="space-y-8">
                <ProgressItem label="Critical" value={stats.categories.critical} color="#e4423a" />
                <ProgressItem label="Urgent" value={stats.categories.high} color="#FF9800" />
                <ProgressItem label="Non-Urgent" value={stats.categories.medium} color="#1976D2" />
              </div>
            </div>

            <div className="col-span-12 lg:col-span-8 bg-white rounded-[40px] border border-gray-100 shadow-soft overflow-hidden">
              <div className="p-10 border-b border-gray-50 flex justify-between items-center">
                <h4 className="text-lg font-black tracking-tight">Active Hotspots</h4>
                <button className="text-xs font-black text-blue-600 uppercase tracking-widest hover:underline transition-all">Full Heatmap</button>
              </div>
              <div className="overflow-x-auto">
                <table className="w-full text-left">
                  <thead>
                    <tr className="bg-gray-50/50">
                      <th className="px-10 py-5 text-[10px] font-black text-gray-400 uppercase tracking-widest">Sector</th>
                      <th className="px-10 py-5 text-[10px] font-black text-gray-400 uppercase tracking-widest text-center">Incidents</th>
                      <th className="px-10 py-5 text-[10px] font-black text-gray-400 uppercase tracking-widest text-right">Risk Level</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-gray-50">
                    <LocationRow name="Student Center" block="Block C" count="12" risk="Critical Zone" color="red" />
                    <LocationRow name="Science Block" block="Lab Wing" count="8" risk="High Traffic" color="orange" />
                    <LocationRow name="Main Library" block="Ground Floor" count="5" risk="Stable" color="green" />
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
  );
};

const NavItem = ({ icon, label, active = false }) => (
  <button className={`w-full flex items-center gap-4 p-4 rounded-2xl transition-all duration-300 group ${active
      ? 'bg-[#e4423a] text-white font-black shadow-lg shadow-red-200'
      : 'text-gray-400 hover:bg-gray-50 hover:text-gray-900'
    }`}>
    <div className={`transition-transform duration-300 ${active ? 'scale-110' : 'group-hover:scale-110'}`}>
      {React.cloneElement(icon, { size: 18, strokeWidth: active ? 3 : 2 })}
    </div>
    <span className="text-xs font-bold tracking-tight">{label}</span>
  </button>
);

const MetricCard = ({ label, value, sub, icon, color, trend }) => (
  <div className="bg-white p-8 rounded-[32px] border border-gray-100 shadow-soft flex flex-col justify-between transition-all hover:-translate-y-1">
    <div className="flex justify-between items-start mb-6">
      <div className={`p-4 rounded-2xl ${color === 'blue' ? 'bg-blue-50' : 'bg-green-50'}`}>
        {icon}
      </div>
      <div className={`flex items-center gap-1 text-[10px] font-black uppercase ${color === 'blue' ? 'text-blue-600' : 'text-green-600'}`}>
        {trend === 'up' ? <TrendingUp size={12} /> : <ArrowDown size={12} />}
        {sub}
      </div>
    </div>
    <div>
      <h4 className="text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] mb-1">{label}</h4>
      <p className="text-4xl font-black text-gray-900 tracking-tight">{value}</p>
    </div>
  </div>
);

const ProgressItem = ({ label, value, color }) => (
  <div>
    <div className="flex justify-between items-end mb-3">
      <span className="text-[10px] font-black text-gray-900 uppercase tracking-widest">{label}</span>
      <span className="text-xs font-black text-gray-400">{value}%</span>
    </div>
    <div className="w-full h-3 bg-gray-50 rounded-full overflow-hidden border border-gray-100">
      <motion.div
        initial={{ width: 0 }}
        animate={{ width: `${value}%` }}
        transition={{ duration: 1.5, ease: "easeOut" }}
        className="h-full rounded-full"
        style={{ backgroundColor: color }}
      />
    </div>
  </div>
);

const LocationRow = ({ name, block, count, risk, color }) => (
  <tr className="hover:bg-gray-50/50 transition-all">
    <td className="px-10 py-6">
      <div className="flex items-center gap-4">
        <div className={`size-10 rounded-xl flex items-center justify-center font-black text-xs ${color === 'red' ? 'bg-red-50 text-red-600' : color === 'orange' ? 'bg-orange-50 text-orange-600' : 'bg-green-50 text-green-600'
          }`}>
          <MapPin size={16} />
        </div>
        <div>
          <p className="text-sm font-black text-gray-900">{name}</p>
          <p className="text-[10px] font-bold text-gray-400 uppercase tracking-tight">{block}</p>
        </div>
      </div>
    </td>
    <td className="px-10 py-6 text-center font-black text-lg text-gray-900">{count}</td>
    <td className="px-10 py-6 text-right">
      <span className={`text-[10px] font-black uppercase tracking-widest ${color === 'red' ? 'text-red-600' : color === 'orange' ? 'text-orange-600' : 'text-green-600'
        }`}>{risk}</span>
    </td>
  </tr>
);

export default SystemAnalyticsDashboard;
