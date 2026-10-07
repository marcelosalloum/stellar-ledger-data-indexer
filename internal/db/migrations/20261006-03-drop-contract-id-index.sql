-- +migrate Up notransaction
-- (contract_id) is the leading column of every other contract_data index, so
-- the planner already has a prefix for contract_id lookups. 7 GB on pubnet.
DROP INDEX CONCURRENTLY IF EXISTS idx_contract_data_contract_id;

-- +migrate Down notransaction
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_contract_data_contract_id
ON public.contract_data (contract_id);
