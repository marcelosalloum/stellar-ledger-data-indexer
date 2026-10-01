-- +migrate Up notransaction
-- Rebuild the bloated index (~2.7x siblings) to free disk before new indexes.
-- First statement drops a failed run's leftover.
DROP INDEX CONCURRENTLY IF EXISTS idx_contract_data_contract_id_closed_at_ccnew;

REINDEX INDEX CONCURRENTLY idx_contract_data_contract_id_closed_at;

-- +migrate Down notransaction
