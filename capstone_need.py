import pandas as pd
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report, confusion_matrix

csv_test = pd.read_csv (C:/Users/stat8/Desktop/test_data.csv)
selected_features = ['sex', 'REGION', 'AGE1', 'BMI', 'TOT_CHOL', 'Q_FHX_HTN', 'Q_FHX_DM', 'DRINK', 'smoking', 'Q_PA', 'INCOME', 'BLOODSUGAR']

X = data[selected_features]
y = data['SICK']  # 종속 변수

# 데이터 분할
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# 의사결정나무 모델 생성 및 학습
clf = DecisionTreeClassifier(random_state=42)
clf.fit(X_train, y_train)

# 예측 및 평가
y_pred = clf.predict(X_test)
print(confusion_matrix(y_test, y_pred))
print(classification_report(y_test, y_pred))

# 의사결정나무 시각화
from sklearn.tree import export_graphviz
import graphviz

# DOT 데이터 생성
dot_data = export_graphviz(clf, out_file=None, 
                           feature_names=selected_features,  
                           class_names=['No SICK', 'SICK'],  
                           filled=True, rounded=True,  
                           special_characters=True)  

# 그래프 생성 및 시각화
graph = graphviz.Source(dot_data)  
graph.render("decision_tree")
graph.view()
