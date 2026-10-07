-- +migrate Up notransaction
-- closed_at changes on every upsert, so this index accumulates a dead entry
-- per update. VACUUM makes the space reusable but never shrinks the file, and
-- time-ordered keys never land in the freed slots: 274 GB on pubnet against
-- ~85 GB fresh. Only a rebuild returns the disk. Needs +100 GB free while it
-- runs; lab-backend reads keep using the old copy until the swap.
-- A failed run restarts the pod and re-runs only this file, so it clears its
-- own leftovers first.
DROP INDEX CONCURRENTLY IF EXISTS idx_contract_data_contract_id_closed_at_ccnew;
DROP INDEX CONCURRENTLY IF EXISTS idx_contract_data_contract_id_closed_at_ccnew1;

REINDEX INDEX CONCURRENTLY idx_contract_data_contract_id_closed_at;

-- +migrate Down notransaction
