export default function ErrorState({ message, onRetry }) {
  return (
    <div className="error-banner" role="alert">
      <span>{message}</span>
      {onRetry ? (
        <button className="link-button" type="button" onClick={onRetry}>
          重试
        </button>
      ) : null}
    </div>
  );
}
