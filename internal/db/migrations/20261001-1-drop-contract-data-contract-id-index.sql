-- +migrate Up notransaction
-- Prefix of all other contract_id indexes.
DROP INDEX CONCURRENTLY IF EXISTS idx_contract_data_contract_id;

-- +migrate Down notransaction
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_contract_data_contract_id
ON public.contract_data (contract_id);
