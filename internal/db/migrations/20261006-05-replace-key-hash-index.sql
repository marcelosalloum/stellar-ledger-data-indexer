-- +migrate Up notransaction
-- key_hash is the primary key, so the trailing ledger_sequence DESC in
-- idx_contract_data_contract_id_key_hash_ledger_sequence_desc never orders
-- anything, but it changes on every upsert and bloats the index (100 GB on
-- pubnet, ~67 fresh). (contract_id, key_hash) serves the same lookups and
-- key_hash sorts, and its key never changes after insert.
-- Build the replacement before dropping the old index so lab-backend queries
-- always have one. Needs +70 GB free while it runs.
-- CREATE INDEX ... IF NOT EXISTS does not repair an INVALID index left by a
-- failed build, so the exact name is dropped first.
DROP INDEX CONCURRENTLY IF EXISTS idx_contract_data_contract_id_key_hash;

CREATE INDEX CONCURRENTLY idx_contract_data_contract_id_key_hash
ON public.contract_data (contract_id, key_hash);

DROP INDEX CONCURRENTLY IF EXISTS idx_contract_data_contract_id_key_hash_ledger_sequence_desc;

-- +migrate Down notransaction
DROP INDEX CONCURRENTLY IF EXISTS idx_contract_data_contract_id_key_hash_ledger_sequence_desc;

CREATE INDEX CONCURRENTLY idx_contract_data_contract_id_key_hash_ledger_sequence_desc
ON public.contract_data (contract_id, key_hash, ledger_sequence DESC);

DROP INDEX CONCURRENTLY IF EXISTS idx_contract_data_contract_id_key_hash;
