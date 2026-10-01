-- +migrate Up notransaction
-- lab-backend: filter_key with default key_hash sort and /keys endpoint.
-- First statement drops a failed run's INVALID leftover.
DROP INDEX CONCURRENTLY IF EXISTS idx_contract_data_contract_id_key_symbol_key_hash;

CREATE INDEX CONCURRENTLY idx_contract_data_contract_id_key_symbol_key_hash
ON public.contract_data (contract_id, key_symbol, key_hash);

-- +migrate Down notransaction
DROP INDEX CONCURRENTLY IF EXISTS idx_contract_data_contract_id_key_symbol_key_hash;
