CREATE OR REPLACE TRIGGER trg_judete_upd_after_row
AFTER UPDATE OF jud ON judete
FOR EACH ROW
BEGIN
UPDATE localitati SET jud=:NEW.jud WHERE jud=:OLD.jud;
END;
/

CREATE OR REPLACE TRIGGER trg_localitati_upd_after_row
AFTER UPDATE OF codpost ON localitati
FOR EACH ROW
BEGIN
UPDATE echipe SET codpost=:NEW.codpost WHERE codpost=:OLD.codpost;
UPDATE stadioane SET codpost=:NEW.codpost WHERE codpost=:OLD.codpost;
END;
/


CREATE OR REPLACE TRIGGER trg_stadioane_upd_after_row
AFTER UPDATE OF codstad ON stadioane
FOR EACH ROW
BEGIN
UPDATE meciuri SET codstad=:NEW.codstad WHERE codstad=:OLD.codstad;
END;
/


CREATE OR REPLACE TRIGGER trg_divizii_upd_after_row
AFTER UPDATE OF coddiv ON divizii
FOR EACH ROW
BEGIN
UPDATE echipe SET coddiv=:NEW.coddiv WHERE coddiv=:OLD.coddiv;
END;
/


CREATE OR REPLACE TRIGGER trg_jucatori_upd_after_row
AFTER UPDATE OF codjuc ON jucatori
FOR EACH ROW
BEGIN
UPDATE contract SET codjuc=:NEW.codjuc WHERE codjuc=:OLD.codjuc;
UPDATE transferuri SET codjuc=:NEW.codjuc WHERE codjuc=:OLD.codjuc;
UPDATE meciuri_goluri SET codjuc=:NEW.codjuc WHERE codjuc=:OLD.codjuc;
UPDATE jucatori_meciuri SET codjuc=:NEW.codjuc WHERE codjuc=:OLD.codjuc;
END;
/

CREATE OR REPLACE TRIGGER trg_echipe_upd_after_row
AFTER UPDATE OF idech ON echipe
FOR EACH ROW
BEGIN
UPDATE jucatori SET idech=:NEW.idech WHERE idech=:OLD.idech;
UPDATE meciuri SET idech1=:NEW.idech WHERE idech1=:OLD.idech;
UPDATE meciuri SET idech2=:NEW.idech WHERE idech2=:OLD.idech;
UPDATE transferuri SET idechn=:NEW.idech WHERE idechn=:OLD.idech;
UPDATE transferuri SET idechp=:NEW.idech WHERE idechp=:OLD.idech;
UPDATE meciuri_goluri SET idech=:NEW.idech WHERE idech=:OLD.idech;
UPDATE Jucatori_meciuri SET idech=:NEW.idech WHERE idech=:OLD.idech;
UPDATE puncte SET idech=:NEW.idech WHERE idech=:OLD.idech;
END;
/


CREATE OR REPLACE TRIGGER trg_meciuri_upd_after_row
AFTER UPDATE OF idmeci ON meciuri
FOR EACH ROW
BEGIN
UPDATE meciuri_goluri SET idmeci=:NEW.idmeci WHERE idmeci=:OLD.idmeci;
UPDATE jucatori_meciuri SET idmeci=:NEW.idmeci WHERE idmeci=:OLD.idmeci;
END;
/

CREATE OR REPLACE TRIGGER trg_meciuri_ins_aft_row
AFTER INSERT ON meciuri
FOR EACH ROW
BEGIN
UPDATE puncte SET nr_mec_juc=nvl(nr_mec_juc,0)+1 WHERE idech=:NEW.idech1 or idech=:NEW.idech2;
 if :NEW.nrgolech1>:NEW.nrgolech2 then
		update puncte set nr_mec_cast=nvl(nr_mec_cast,0)+1 WHERE idech=:NEW.idech1;
		update puncte set nr_mec_pier=nvl(nr_mec_pier,0)+1 WHERE idech=:NEW.idech2;
		UPDATE puncte set punctaj=nvl(punctaj,0)+3 where idech=:new.idech1;
		UPDATE puncte set punctaj=nvl(punctaj,0)+1 where idech=:new.idech2;
end if;
 if :NEW.nrgolech1<:NEW.nrgolech2 then
		update puncte set nr_mec_cast=nvl(nr_mec_cast,0)+1 WHERE idech=:NEW.idech2;
		update puncte set nr_mec_pier=nvl(nr_mec_pier,0)+1 WHERE idech=:NEW.idech1;
		UPDATE puncte set punctaj=nvl(punctaj,0)+1 where idech=:new.idech1;
		UPDATE puncte set punctaj=nvl(punctaj,0)+3 where idech=:new.idech2;
end if;
 if :NEW.nrgolech1=:NEW.nrgolech2 then
		update puncte set nr_mec_egal=nvl(nr_mec_egal,0)+1 WHERE idech=:NEW.idech2;
		update puncte set nr_mec_egal=nvl(nr_mec_egal,0)+1 WHERE idech=:NEW.idech1;
		UPDATE puncte set punctaj=nvl(punctaj,0)+2 where idech=:new.idech1;
		UPDATE puncte set punctaj=nvl(punctaj,0)+2 where idech=:new.idech2;
end if;

END;
/
