import { useEffect, useState } from 'react';
import { fetchLogDashboard } from '../api/dashboard.js';
import LoadingState from '../components/LoadingState.jsx';
import ErrorState from '../components/ErrorState.jsx';
import SectionCard from '../components/SectionCard.jsx';
import Tag from '../components/Tag.jsx';

const badgeToneMap = {
  PRIMARY: 'primary',
  OUTLINE: 'outline',
  WARNING: 'warning'
};

export default function LogDashboard({ userId }) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const load = async () => {
    try {
      setLoading(true);
      setError(null);
      const response = await fetchLogDashboard(userId);
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

  const { context, metrics, timeline, manualCapture } = data;
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

      <SectionCard title="今日概览">
        <div className="grid two">
          {metrics.map((metric) => (
            <div key={metric.id} className="card" style={{ boxShadow: 'none' }}>
              <h3 style={{ margin: '0 0 6px' }}>{metric.label}</h3>
              <strong style={{ fontSize: 24, color: '#0f172a' }}>{metric.value}</strong>
              <p style={{ margin: '6px 0 0', color: '#475569', fontSize: 13 }}>{metric.detail}</p>
            </div>
          ))}
        </div>
      </SectionCard>

      <SectionCard title="捕捉时间线" subtitle="自动 + 手动数据事件">
        <div className="timeline">
          {timeline.map((entry) => (
            <div key={entry.id} className="timeline-entry">
              <time>{entry.time}</time>
              <h4>{entry.title}</h4>
              <p>{entry.meta}</p>
              <p>{entry.detail}</p>
            </div>
          ))}
        </div>
      </SectionCard>

      <SectionCard
        title={manualCapture.headline}
        subtitle={manualCapture.body}
        actionSlot={<Tag text={manualCapture.badgeText} tone={badgeToneMap[manualCapture.badgeStyle] || 'primary'} />}
      >
        <button
          type="button"
          className={
            manualCapture.buttonKind === 'PRIMARY' ? 'primary-button' : 'ghost-button'
          }
        >
          {manualCapture.buttonTitle}
        </button>
      </SectionCard>
    </div>
  );
}
