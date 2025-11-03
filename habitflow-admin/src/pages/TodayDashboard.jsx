import { useEffect, useState } from 'react';
import { fetchTodayDashboard } from '../api/dashboard.js';
import LoadingState from '../components/LoadingState.jsx';
import ErrorState from '../components/ErrorState.jsx';
import SectionCard from '../components/SectionCard.jsx';
import Tag from '../components/Tag.jsx';

const badgeToneMap = {
  PRIMARY: 'primary',
  OUTLINE: 'outline',
  WARNING: 'warning'
};

export default function TodayDashboard({ userId }) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const load = async () => {
    try {
      setLoading(true);
      setError(null);
      const response = await fetchTodayDashboard(userId);
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

  const { context, plan, insight, quickActions, chatThread } = data;
  const badgeTone = badgeToneMap[context.badge?.style] || 'primary';

  return (
    <div className="grid" style={{ gap: 24 }}>
      {loading ? <LoadingState label="刷新中…" /> : null}
      {error ? <ErrorState message={error} onRetry={load} /> : null}

      <SectionCard
        title="状态栏信息"
        subtitle={`${context.timestamp} · ${context.title}`}
        actionSlot={
          context.goalChip ? <Tag text={context.goalChip} tone="outline" /> : null
        }
      >
        <div className="status-bar">
          <span>{context.statusBarTime}</span>
          <span>
            {context.badge ? <Tag text={context.badge.text} tone={badgeTone} /> : null}
          </span>
        </div>
        {context.subtitle ? (
          <p style={{ marginTop: 12, color: '#475569', fontSize: 14 }}>{context.subtitle}</p>
        ) : null}
      </SectionCard>

      <div className="grid two">
        <SectionCard title={plan.title} subtitle={plan.summary}>
          <ul className="metadata-list">
            {(plan.metadata || []).map((item) => (
              <li key={item} className="metadata-badge">
                {item}
              </li>
            ))}
          </ul>
          <div className="button-row" style={{ marginTop: 16 }}>
            {(plan.actions || []).map((action) => (
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

        <SectionCard
          title={insight.title}
          subtitle={insight.body}
          actionSlot={<Tag text={insight.evidenceLevel} tone="warning" />}
        >
          <div className="button-row" style={{ marginTop: 16 }}>
            {(insight.actions || []).map((action) => (
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
      </div>

      <SectionCard title="一键执行" subtitle="快速触发微目标动作">
        <div
          className="grid"
          style={{ gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))', gap: 16 }}
        >
          {quickActions.map((action) => (
            <div key={action.id} className="card" style={{ boxShadow: 'none' }}>
              <h3 style={{ margin: '0 0 6px' }}>{action.title}</h3>
              <p style={{ margin: 0, color: '#475569', fontSize: 13 }}>{action.caption}</p>
              <span style={{ fontSize: 12, marginTop: 8, display: 'inline-block', color: '#2563eb' }}>
                {action.domain}
              </span>
            </div>
          ))}
        </div>
      </SectionCard>

      <SectionCard title="教练对话" subtitle="最新互动记录">
        <div className="grid" style={{ gap: 16 }}>
          {chatThread.map((message) => (
            <div
              key={message.id}
              style={{
                padding: 16,
                borderRadius: 14,
                background:
                  message.role === 'AI'
                    ? 'linear-gradient(135deg, rgba(37,99,235,0.08), rgba(59,130,246,0.12))'
                    : 'rgba(255,255,255,0.8)',
                border:
                  message.role === 'AI'
                    ? '1px solid rgba(59,130,246,0.18)'
                    : '1px solid rgba(148,163,184,0.14)'
              }}
            >
              <strong style={{ fontSize: 13, color: '#2563eb' }}>
                {message.role === 'AI' ? 'AI 教练' : '用户'}
              </strong>
              <p style={{ margin: '8px 0 0', color: '#1e293b', fontSize: 14 }}>{message.text}</p>
            </div>
          ))}
        </div>
      </SectionCard>
    </div>
  );
}
