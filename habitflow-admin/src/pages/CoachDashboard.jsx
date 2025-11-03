import { useEffect, useState } from 'react';
import { fetchCoachDashboard } from '../api/dashboard.js';
import LoadingState from '../components/LoadingState.jsx';
import ErrorState from '../components/ErrorState.jsx';
import SectionCard from '../components/SectionCard.jsx';
import Tag from '../components/Tag.jsx';

const badgeToneMap = {
  PRIMARY: 'primary',
  OUTLINE: 'outline',
  WARNING: 'warning'
};

export default function CoachDashboard({ userId }) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const load = async () => {
    try {
      setLoading(true);
      setError(null);
      const response = await fetchCoachDashboard(userId);
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

  const { context, thread, recommendation, composer } = data;
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

      <SectionCard title="对话线程">
        <div className="grid" style={{ gap: 16 }}>
          {thread.map((message) => (
            <div
              key={message.id}
              style={{
                display: 'flex',
                flexDirection: 'column',
                gap: 6,
                background:
                  message.role === 'AI'
                    ? 'rgba(37, 99, 235, 0.08)'
                    : 'rgba(255, 255, 255, 0.8)',
                borderRadius: 14,
                padding: 16,
                border:
                  message.role === 'AI'
                    ? '1px solid rgba(37, 99, 235, 0.22)'
                    : '1px solid rgba(148, 163, 184, 0.18)'
              }}
            >
              <span style={{ fontSize: 13, fontWeight: 600, color: '#2563eb' }}>
                {message.role === 'AI' ? 'AI 教练' : '用户'}
              </span>
              <span style={{ color: '#1e293b', fontSize: 14 }}>{message.text}</span>
            </div>
          ))}
        </div>
      </SectionCard>

      <div className="grid two">
        <SectionCard
          title="推荐依据"
          subtitle={recommendation.summary}
          actionSlot={<Tag text={recommendation.evidenceTag} tone="warning" />}
        >
          <p style={{ fontSize: 13, color: '#475569', margin: 0 }}>{recommendation.dataWindow}</p>
          <div className="button-row" style={{ marginTop: 16 }}>
            {(recommendation.actions || []).map((action) => (
              <button
                key={action.title}
                type="button"
                className={action.kind === 'PRIMARY' ? 'primary-button' : 'ghost-button'}
              >
                {action.title}
              </button>
            ))}
          </div>
        </SectionCard>

        <SectionCard title="对话提示" subtitle={recommendation.closingHint ?? '保持节奏'}>
          <p style={{ fontSize: 13, color: '#475569', marginTop: 0 }}>{composer.prompt}</p>
          <div style={{ marginTop: 12 }}>
            <input
              type="text"
              disabled
              value={composer.placeholder}
              style={{
                width: '100%',
                padding: '10px 12px',
                borderRadius: 12,
                border: '1px solid rgba(148, 163, 184, 0.4)',
                background: 'rgba(248, 250, 252, 0.7)',
                color: '#94a3b8'
              }}
            />
          </div>
          <button
            type="button"
            className={composer.buttonKind === 'PRIMARY' ? 'primary-button' : 'ghost-button'}
            style={{ marginTop: 16 }}
          >
            {composer.submitTitle}
          </button>
        </SectionCard>
      </div>
    </div>
  );
}
