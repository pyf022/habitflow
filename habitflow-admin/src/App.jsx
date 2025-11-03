import { useMemo, useState } from 'react';
import { NavLink, Navigate, Route, Routes, useLocation } from 'react-router-dom';
import TodayDashboard from './pages/TodayDashboard.jsx';
import CoachDashboard from './pages/CoachDashboard.jsx';
import LogDashboard from './pages/LogDashboard.jsx';
import WeeklyDashboard from './pages/WeeklyDashboard.jsx';
import ProfileDashboard from './pages/ProfileDashboard.jsx';

const navItems = [
  { label: '今日面板', path: '/today', description: '微目标与即时洞察' },
  { label: 'AI 教练', path: '/coach', description: '对话与推荐' },
  { label: '数据记录', path: '/log', description: '每日数据捕捉' },
  { label: '周报洞察', path: '/weekly', description: '周期跟踪与计划' },
  { label: '账号中心', path: '/profile', description: '偏好与隐私' }
];

export default function App() {
  const location = useLocation();
  const [userId, setUserId] = useState(1);

  const currentRoute = useMemo(
    () => navItems.find((item) => location.pathname.startsWith(item.path)),
    [location.pathname]
  );

  const handleUserIdChange = (event) => {
    const value = Number.parseInt(event.target.value, 10);
    if (!Number.isNaN(value) && value > 0) {
      setUserId(value);
    }
  };

  return (
    <div className="app-shell">
      <aside className="sidebar">
        <div className="sidebar-header">
          <span style={{ fontSize: '15px', letterSpacing: '0.08em', textTransform: 'uppercase' }}>
            HabitFlow
          </span>
          <strong style={{ fontSize: '22px' }}>管理面板</strong>
          <span style={{ fontSize: '13px', color: 'rgba(226, 232, 240, 0.7)' }}>
            连接 KMM / iOS 预览与后端数据
          </span>
        </div>

        <nav className="sidebar-nav">
          {navItems.map((item) => (
            <NavLink
              key={item.path}
              to={item.path}
              className={({ isActive }) =>
                isActive ? 'sidebar-link sidebar-link-active' : 'sidebar-link'
              }
            >
              {item.label}
            </NavLink>
          ))}
        </nav>
      </aside>

      <main className="content">
        <div className="content-header">
          <div>
            <h1>{currentRoute?.label ?? 'HabitFlow 数据总览'}</h1>
            <p style={{ margin: 0, color: '#475569' }}>{currentRoute?.description}</p>
          </div>
          <div className="toolbar">
            <span className="pill">User ID</span>
            <input
              type="number"
              min={1}
              value={userId}
              onChange={handleUserIdChange}
              aria-label="User ID"
            />
          </div>
        </div>

        <Routes>
          <Route path="/" element={<Navigate to="/today" replace />} />
          <Route path="/today" element={<TodayDashboard userId={userId} />} />
          <Route path="/coach" element={<CoachDashboard userId={userId} />} />
          <Route path="/log" element={<LogDashboard userId={userId} />} />
          <Route path="/weekly" element={<WeeklyDashboard userId={userId} />} />
          <Route path="/profile" element={<ProfileDashboard userId={userId} />} />
        </Routes>
      </main>
    </div>
  );
}
