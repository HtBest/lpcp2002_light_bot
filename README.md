# lpcp2022_light_bot

## Quick start
1. preprocess input data: ```cat problem-4/instance.1.in | ./pre.py >out.lp```

2. run clingo: ```clingo light_bot.lp out.lp >res.out```

3. postprocess output data: ```cat res.out | ./post.py >res2.out```

4. check result: ```(cat problem-4/instance.1.in; res2.out) | ./checker.py```

## Test
one line to run case 1:```(cat problem-4/instance.1.in; cat problem-4/instance.1.in | ./pre.py >out.lp && clingo light_bot.lp out.lp | ./post.py) | ./checker.py 2&>1 > res```

test all cases: ```for i in $(seq 1 10) do ((cat problem-4/instance.$i.in; cat problem-4/instance.$i.in | ./pre.py >out.lp && clingo light_bot.lp out.lp | ./post.py) | ./checker.py 2&>1 > result-$i.out );done```

## Support
If you find my work helpful, I would greatly appreciate it if you could star ⭐️ my repository.