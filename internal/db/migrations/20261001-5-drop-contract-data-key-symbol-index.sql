-- +migrate Up notransaction
-- Prefix of idx_contract_data_contract_id_key_symbol_key_hash.
DROP INDEX CONCURRENTLY IF EXISTS idx_contract_data_contract_id_key_symbol;

-- +migrate Down notransaction
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_contract_data_contract_id_key_symbol
ON public.contract_data (contract_id, key_symbol)
WHERE key_symbol IS NOT NULL;
