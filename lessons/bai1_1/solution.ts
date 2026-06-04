
export type Block = {
  index: number;
  timestamp: string;
  transactions: any[];
  previous_hash: string;
  current_hash: string;
};

// ✍️ TODO: Viết hàm tại đây
export function isValidBlock(block: Block): boolean {
  // Basic validation
  if (!block) return false;

  // Deterministically serialize the transactions array
  const txString = JSON.stringify(block.transactions || []);

  const data = `${block.index}${block.timestamp}${txString}${block.previous_hash}`;

  // Use Node's crypto to compute SHA256
  // Note: runtime must be Node.js or compatible environment
  // eslint-disable-next-line @typescript-eslint/no-var-requires
  const crypto = require('crypto');
  const hash = crypto.createHash('sha256').update(data).digest('hex');

  return hash === block.current_hash;
}
