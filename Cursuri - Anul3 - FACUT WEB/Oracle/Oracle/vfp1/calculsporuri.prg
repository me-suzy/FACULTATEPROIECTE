dime a_ore(3)
if !used ('personal')
    use personal in 0
endif
if !used ('sporuri')
    use sporuri in 0
endif
v_anul=2003
v_luna=10
select personal
scan for !personal.colaborator
    v_data= ctod("1"+"/" + str(v_luna)+"/"+str(v_anul))
    select sum(orelucrate), sum(oreco), sum(orenoapte);
        from pontaje where marca= personal.marca and;
        month(data)=v_luna and year(data)=v_anul;
        into array a_ore
        
    venitbaza = a_ore(1)*personal.salorar+a_ore(2)*personal.salorarco
    suspend
    sporvechime = venitbaza*calcul_procentsv (v_data, personal.datasv)
    spornoapte= a_ore(3)*personal.salorar*0.15
    if !indexseek (str(personal.marca,5)+str(v_anul,4)+str(v_luna,2),.f.,;
            "sporuri","pk_sporuri")
        insert into sporuri(an, luna, marca, spvech, orenoapte, spnoapte);
            values(v_anul, v_luna, personal.marca, sporvechime, a_ore(3), spornoapte)
    else
        update sporuri set spvech=sporvechime, orenoapte=a_ore(3),;
            spnoapte=spornoapte where marca=personal.marca;
            and luna=v_luna and an=v_anul
    endif
endscan

procedure calcul_procentsv
parameter datacalcul, datavechime
if !used ('transe_sv')
    use transe_sv in 0
endif
select transe_sv
scan
    if gomonth (datacalcul,-ani_limita_sup*12)<datavechime;
            and gomonth (datacalcul,-ani_limita_inf*12)>=datavechime
        ? transe_sv.procent_sv
        return transe_sv.procent_sv
    endif
endscan
endproc
*do calcul_procentsv in calculsporuri with {^2003/10/01}, {^1998/09/09}
