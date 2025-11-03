import { useEffect, useState } from 'react';
import { fetchProfileDashboard } from '../api/dashboard.js';
import LoadingState from '../components/LoadingState.jsx';
import ErrorState from '../components/ErrorState.jsx';
import SectionCard from '../components/SectionCard.jsx';
import Tag from '../components/Tag.jsx';

const badgeToneMap = {
  PRIMARY: 'primary',
  OUTLINE: 'outline',
  WARNING: 'warning'
};

export default function ProfileDashboard({ userId }) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const load = async () => {
    try {
      setLoading(true);
      setError(null);
      const response = await fetchProfileDashboard(userId);
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

  const { context, identity, dataStrategy, settings, links, dataAuthorizations } = data;
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

      <SectionCard title="账号与偏好">
        <div className="grid two">
          <div className="card" style={{ boxShadow: 'none' }}>
            <div style={{ display: 'flex', gap: 16, alignItems: 'center' }}>
              <div
                style={{
                  width: 60,
                  height: 60,
                  borderRadius: '50%',
                  background: 'rgba(37,99,235,0.18)',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  fontWeight: 700,
                  color: '#2563eb',
                  fontSize: 20
                }}
              >
                {identity.initials}
              </div>
              <div>
                <strong style={{ fontSize: 18 }}>{identity.displayName}</strong>
                <p style={{ margin: '6px 0 4px', color: '#475569' }}>{identity.email}</p>
                <Tag text={`${identity.lastSyncLabel} · ${identity.experimentTag}`} tone="outline" />
              </div>
            </div>
          </div>
          <div className="card" style={{ boxShadow: 'none' }}>
            <h3 style={{ margin: '0 0 12px' }}>偏好设置</h3>
            <ul className="list">
              {(settings || []).map((item) => (
                <li key={item.id} className="list-item">
                  <div>
                    <strong>{item.title}</strong>
                    <span>{item.enabled ? '已开启' : '已关闭'}</span>
                  </div>
                </li>
              ))}
            </ul>
          </div>
        </div>
      </SectionCard>

      <SectionCard title="数据策略摘要" subtitle={dataStrategy.summary}>
        <div className="button-row">
          {(dataStrategy.actions || []).map((action) => (
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

      <SectionCard title="常用链接" subtitle="隐私、数据导出等快捷入口">
        <ul className="list">
          {(links || []).map((item) => (
            <li key={item.id} className="list-item">
              <div>
                <strong>{item.title}</strong>
                <span>图标：{item.icon}</span>
              </div>
            </li>
          ))}
        </ul>
      </SectionCard>

      <SectionCard title="数据授权矩阵">
        <div className="grid" style={{ gap: 16 }}>
          {(dataAuthorizations || []).map((item) => (
            <div key={item.id} className="card" style={{ boxShadow: 'none' }}>
              <h3 style={{ margin: '0 0 8px' }}>{item.scope}</h3>
              <Tag text={item.status} tone="outline" />
              <button
                type="button"
                className={item.buttonKind === 'PRIMARY' ? 'primary-button' : 'ghost-button'}
                style={{ marginTop: 16 }}
              >
                {item.actionTitle}
              </button>
            </div>
          ))}
        </div>
      </SectionCard>
    </div>
  );
}
