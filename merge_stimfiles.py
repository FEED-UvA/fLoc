import pandas as pd
from glob import glob

files = sorted(glob('sub*.tsv'))
dfs = []
for f in files:
    sub = f.split('_')[0]
    df = pd.read_csv(f, sep='\t')
    df['sub_id'] = sub
    dfs.append(df)

df = pd.concat(dfs)
df.to_csv('fLoc_trials.tsv', sep='\t', index=False)
