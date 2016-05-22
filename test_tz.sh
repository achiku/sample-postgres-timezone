#!/bin/bash

exec_sql()
{
    cat <<-EOSQL | psql -q -U tztest
    ${1}
EOSQL
}

create_data()
{
    exec_sql "INSERT INTO t1 (tz, notz) values (now(), now());"
    exec_sql "INSERT INTO t1 (tz, notz) values ('1985-08-18 21:11:22.455555', '1985-08-18 21:11:22.455555');"
}

select_data()
{
    exec_sql "SELECT * FROM t1;"
}

select_data_with_tz_setting()
{
    exec_sql "set timezone='UTC'; SELECT * FROM t1;"
}

delete_data()
{
    exec_sql "DELETE FROM t1;"
}


create_data
select_data
select_data_with_tz_setting
delete_data
