import pandas as pd
import numpy as np
from statsmodels.formula.api import ols
from statsmodels.stats.anova import anova_lm

# 데이터 생성 (예시)
data1 = pd.DataFrame({
    "Factor1": ['n','p','n','p','n','p','n','p','n','p','n','p','n','p','n','p'],
    "Factor2": ['n','n','p','p','n','n','p','p','n','n','p','p','n','n','p','p'],
    "Factor3": ['n','n','n','n','p','p','p','p','n','n','n','n','p','p','p','p'],
    "Factor4": ['n','n','n','n','n','n','n','n','p','p','p','p','p','p','p','p'],
    "Response": [90, 74, 81, 83, 77, 81, 88, 73, 98, 72, 87, 85, 99, 79, 87, 80], 
})

data2 = pd.DataFrame({
    "Factor1": ['n','p','n','p','n','p','n','p','n','p','n','p','n','p','n','p'],
    "Factor2": ['n','n','p','p','n','n','p','p','n','n','p','p','n','n','p','p'],
    "Factor3": ['n','n','n','n','p','p','p','p','n','n','n','n','p','p','p','p'],
    "Factor4": ['n','n','n','n','n','n','n','n','p','p','p','p','p','p','p','p'],
    "Response": [93, 78, 85, 80, 78, 80, 82, 70, 95, 76, 83, 86, 90, 75, 84, 80], 
})

data = pd.concat([data1, data2], axis=0, ignore_index=True)

# 4요인 분산분석을 위한 모델 정의
model = ols("Response ~ C(Factor1) * C(Factor2) * C(Factor3) * C(Factor4)", data=data).fit()

# ANOVA 결과 출력
anova_results = anova_lm(model, typ=2)
print(anova_results)
