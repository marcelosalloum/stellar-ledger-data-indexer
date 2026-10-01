-- +migrate Up notransaction
-- lab-backend: filter_key with sort_by=updated_at.
-- First statement drops a failed run's INVALID leftover.
DROP INDEX CONCURRENTLY IF EXISTS idx_contract_data_contract_id_key_symbol_closed_at;

CREATE INDEX CONCURRENTLY idx_contract_data_contract_id_key_symbol_closed_at
ON public.contract_data (contract_id, key_symbol, closed_at DESC, key_hash DESC);

-- +migrate Down notransaction
DROP INDEX CONCURRENTLY IF EXISTS idx_contract_data_contract_id_key_symbol_closed_at;
