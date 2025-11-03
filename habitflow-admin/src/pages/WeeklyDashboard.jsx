import { useEffect, useState } from 'react';
import { fetchWeeklyDashboard } from '../api/dashboard.js';
import LoadingState from '../components/LoadingState.jsx';
import ErrorState from '../components/ErrorState.jsx';
import SectionCard from '../components/SectionCard.jsx';
import Tag from '../components/Tag.jsx';

const badgeToneMap = {
  PRIMARY: 'primary',
  OUTLINE: 'outline',
  WARNING: 'warning'
};

export default function WeeklyDashboard({ userId }) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const load = async () => {
    try {
      setLoading(true);
      setError(null);
      const response = await fetchWeeklyDashboard(userId);
      setData(response);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    load();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [userId]);

  if (loading && !data) {
    return <LoadingState />;
  }

  if (error && !data) {
    return <ErrorState message={error} onRetry={load} />;
  }

  if (!data) {
    return null;
  }

  const { context, summary, insights, plan } = data;
  const badgeTone = badgeToneMap[context.badge?.style] || 'primary';

  return (
    <div className="grid" style={{ gap: 24 }}>
      {loading ? <LoadingState label="刷新中…" /> : null}
      {error ? <ErrorState message={error} onRetry={load} /> : null}

      <SectionCard
        title={context.title}
        subtitle={`${context.timestamp} · ${context.subtitle ?? ''}`}
        actionSlot={
          context.badge ? <Tag text={context.badge.text} tone={badgeTone} /> : null
        }
      >
        <p style={{ margin: 0, color: '#475569', fontSize: 14 }}>{context.goalChip}</p>
      </SectionCard>

      <SectionCard title="周度概览" subtitle="关键 KPI 与总结">
        <div className="grid two">
          <div
            className="card"
            style={{
              boxShadow: 'none',
              background: 'linear-gradient(135deg, rgba(37, 99, 235, 0.12), rgba(59, 130, 246, 0.18))'
            }}
          >
            <h3 style={{ margin: '0 0 6px' }}>综合完成率</h3>
            <strong style={{ fontSize: 32, color: '#1d4ed8' }}>
              {Math.round(summary.progressRatio * 100)}%
            </strong>
            <p style={{ margin: '8px 0 0', color: '#1e293b', fontWeight: 600 }}>
              {summary.trendValue} {summary.trendLabel}
            </p>
          </div>
          <div className="card" style={{ boxShadow: 'none' }}>
            <h3 style={{ margin: '0 0 8px' }}>总结</h3>
            <ul style={{ margin: 0, paddingLeft: 20, color: '#475569', fontSize: 14 }}>
              {summary.summaryLines?.map((line) => (
                <li key={line} style={{ marginBottom: 6 }}>
                  {line}
                </li>
              ))}
            </ul>
          </div>
        </div>
      </SectionCard>

      <SectionCard title="重点洞察">
        <div className="grid" style={{ gap: 16 }}>
          {insights.map((item) => (
            <div key={item.id} className="card" style={{ boxShadow: 'none' }}>
              <h3>{item.title}</h3>
              <p style={{ margin: '6px 0 12px', color: '#475569', fontSize: 14 }}>{item.detail}</p>
              <button type="button" className="link-button">
                {item.cta}
              </button>
            </div>
          ))}
        </div>
      </SectionCard>

      <SectionCard title="下周计划" subtitle="AI 推荐微行动列表">
        <div className="grid" style={{ gap: 16 }}>
          {plan.map((item) => (
            <div key={item.id} className="card" style={{ boxShadow: 'none' }}>
              <h3 style={{ margin: '0 0 10px' }}>{item.title}</h3>
              <div className="metadata-list">
                {(item.metadata || []).map((meta) => (
                  <span key={`${meta.label}-${meta.value}`} className="metadata-badge">
                    {meta.label}
                    {meta.value ? ` · ${meta.value}` : ''}
                  </span>
                ))}
              </div>
              <button
                type="button"
                className={item.buttonKind === 'PRIMARY' ? 'primary-button' : 'ghost-button'}
                style={{ marginTop: 16 }}
              >
                {item.buttonTitle}
              </button>
            </div>
          ))}
        </div>
      </SectionCard>
    </div>
  );
}
