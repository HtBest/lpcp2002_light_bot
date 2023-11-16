# lpcp2022_light_bot

preprocess input data: ```cat problem-4/instance.1.in | ./pre.py >out.lp```

run clingo: ```clingo light_bot.lp out.lp >res.out```

postprocess output data: ```cat res.out | ./post.py >res2.out```

check result: ```(cat problem-4/instance.1.in; res2.out) | ./checker.py```

one line to run case 1:```(cat problem-4/instance.1.in; cat problem-4/instance.1.in | ./pre.py >out.lp && clingo light_bot.lp out.lp | ./post.py) | ./checker.py 2&>1 > res```

test all cases: ```for i in $(seq 1 10) do ((cat problem-4/instance.$i.in; cat problem-4/instance.$i.in | ./pre.py >out.lp && clingo light_bot.lp out.lp | ./post.py) | ./checker.py 2&>1 > result-$i.out );done```