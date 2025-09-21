*<>{E99E1D45-39C9-457F-8D8D-247938846156}**********************************
*<> Author:  a-davand
*<> Description:  Display new datatypes in a browse
*<>************************************************************************
CLEAR
cVal= 'string'
CREATE CURSOR Test (f_varchar V(30), f_varbinary Q(30), f_blob W)
INSERT INTO Test VALUES (m.cVal,CREATEBINARY(m.cVal),CREATEBINARY(m.cVal))
cVal= 'this is a much longer string'
INSERT INTO Test VALUES (m.cVal,CREATEBINARY(m.cVal),CREATEBINARY(m.cVal))
cVal= 'this is a much longer string, even longer than the one before'
INSERT INTO Test VALUES (m.cVal,CREATEBINARY(m.cVal),CREATEBINARY(m.cVal))

? 'f_varchar  ',f_varchar
? 'f_varbinary',f_varbinary
? 'f_blob     ', f_blob

MODIFY MEMO f_blob NOWAIT
BROWSE NOWAIT