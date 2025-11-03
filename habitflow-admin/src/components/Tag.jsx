export default function Tag({ text, tone = 'primary' }) {
  return <span className={`tag ${tone}`}>{text}</span>;
}
