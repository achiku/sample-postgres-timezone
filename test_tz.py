# -*- coding: utf-8 -*-
import psycopg2
import pytest


@pytest.yield_fixture()
def conn():
    conn = psycopg2.connect(database="tztest", user="tztest")
    yield conn
    conn.close()


@pytest.yield_fixture()
def cur(conn):
    cur = conn.cursor()
    params = [
        ('now()', 'now()'),
        ('1985-08-19 21:11:20', '1985-08-19 21:11:20'),
    ]
    for p in params:
        cur.execute("INSERT INTO t1 (tz, notz) values (%s, %s)", p)

    yield cur
    cur.execute("rollback")


@pytest.mark.parametrize('tz_cond, expected_cnt', [
        ('now()', 1),
        ('1985-08-19 21:11:20', 1),
])
def test_raw_tz(cur, tz_cond, expected_cnt):
    cur.execute("select * from t1 where tz = %s", (tz_cond,))
    results = cur.fetchall()
    for d in results:
        print(d[0], d[1], d[2])
    assert len(results) == expected_cnt
