using DecisionTree

features, labels = load_data("iris")
typeof(features)
typeof(labels)

features = float.(features)
labels = string.(labels)

model = DecisionTreeClassifier(max_depth=2)
fit!(model, features, labels)

print_tree(model, 5)
predict(model, [5.9, 3.0, 5.1, 1.9])
predict_proba(model, [5.9, 3.0, 5.1, 1.9])
println(get_classes(model))

using ScikitLearn.CrossValidation: cross_val_score
accuracy = cross_val_score(model, features, labels, cv=3)

# Native API
model = build_tree(labels, features)
model = prune_tree(model, 0.9)
print_tree(model, 5)
preds = apply_tree(model, features)

DecisionTree.confusion_matrix(labels, preds)

apply_tree_proba(model, [5.9,3.0,5.1,1.9], ["Iris-setosa", "Iris-versicolor", "Iris-virginica"])

n_folds = 3
accuracy = nfoldCV_forest(labels, features, n_folds)

n_subfeatures=0; max_depth=-1; min_sample_leaf=1; min_sample_split=2;min_purity_increase=0.0; pruning_purity=1.0; seed=3
model = build_tree(labels, features,
                    n_subfeatures,
                    max_depth,
                    min_sample_leaf,
                    min_sample_split,
                    min_purity_increase;
                    rng = seed
                    )

accuracy = nfoldCV_tree(labels, features,
                        n_folds,
                        pruning_purity,
                        max_depth,
                        min_sample_leaf,
                        min_sample_split,
                        min_purity_increase;
                        verbose=true,
                        rng=seed)

# Randomforest
model = build_forest(labels, features, 2, 10, 0.5, 6)
apply_forest(model, [5.9,3.0,5.1,1.9])
apply_forest_proba(model, [5.9,3.0,5.1,1.9], ["Iris-setosa", "Iris-versicolor", "Iris-virginica"])

n_folds=3; n_subfeatures=2
accuracy = nfoldCV_forest(labels, features, n_folds, n_subfeatures)

n_subfeatures=-1; n_trees=10; partial_sampling=0.7; max_depth=-1; min_sample_leaf=5; min_sample_split=2; min_purity_increase=0.0; seed=3

model = build_forest(labels, features,
                     n_subfeatures,
                     n_trees,
                     partial_sampling,
                     max_depth,
                     min_sample_leaf,
                     min_sample_split,
                     min_purity_increase;
                     rng=seed)

accuracy = nfoldCV_forest(labels, features,
                          n_folds, n_subfeatures, n_trees, partial_sampling,
                          max_depth, min_sample_leaf, min_sample_split, min_purity_increase;
                          verbose=true, rng=seed )