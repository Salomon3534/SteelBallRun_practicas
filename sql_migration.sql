-- ============================================================
-- SBR Migration: Runner status + trigger
-- ============================================================

-- 1. Add status column to runner table
ALTER TABLE runner
    ADD COLUMN status ENUM('active', 'retired', 'disqualified') NOT NULL DEFAULT 'active';

-- 2. MySQL trigger: when a medical check is inserted with passed=0,
--    immediately set the runner's status to 'retired'
DROP TRIGGER IF EXISTS trg_medical_check_fail;

DELIMITER $$
CREATE TRIGGER trg_medical_check_fail
AFTER INSERT ON medical_check
FOR EACH ROW
BEGIN
    IF NEW.passed = 0 THEN
        UPDATE runner
           SET status = 'retired'
         WHERE bib = NEW.runner_id
           AND status = 'active';
    END IF;
END$$
DELIMITER ;
