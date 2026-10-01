-- +migrate Up notransaction
-- Purge dead entries at the DESC head; they slow ttl desc first pages.
-- First statement drops a failed run's leftover.
DROP INDEX CONCURRENTLY IF EXISTS idx_contract_data_contract_id_live_until_ccnew;

REINDEX INDEX CONCURRENTLY idx_contract_data_contract_id_live_until;

-- +migrate Down notransaction
