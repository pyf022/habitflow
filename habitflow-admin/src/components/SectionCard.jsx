export default function SectionCard({ title, subtitle, actionSlot, children }) {
  return (
    <section className="card">
      <header style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
        <div>
          <h2>{title}</h2>
          {subtitle ? <p style={{ margin: '4px 0 0', color: '#475569' }}>{subtitle}</p> : null}
        </div>
        {actionSlot ?? null}
      </header>
      <div style={{ marginTop: 16 }}>{children}</div>
    </section>
  );
}
