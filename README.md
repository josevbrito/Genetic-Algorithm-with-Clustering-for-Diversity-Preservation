# Genetic Algorithm with Clustering for Diversity Preservation

This repository contains the implementation of **Activity I** for the course **Applied Evolutionary Computation**, part of the Master's program in Computer Science at **UFMA (Universidade Federal do Maranhão)**, taught by **Prof. Omar Andres Carmona Cortes**.

## 🧠 Activity Overview

The objective of this activity is to modify the Real-Coded Genetic Algorithm (RCGA) provided by the professor to include clustering techniques in order to maintain population diversity. The performance of this modified algorithm is compared against the standard genetic algorithm under different configurations.

## 🔗 Original Code Reference

The original RCGA code can be found at the following repository:

👉 [https://gitlab.com/omar.carmona/real-coded-genetic-algorithm](https://gitlab.com/omar.carmona/real-coded-genetic-algorithm)

## 🏗️ Modifications Implemented

- **Incorporated clustering mechanisms** to preserve diversity in the population.
- The following clustering algorithms were used:
  - K-Means
  - Hierarchical Clustering
  - DBSCAN
- The modified GA includes:
  - Evaluation function only.
  - Evaluation function + clustering.

## ⚙️ Experimental Setup

### Comparative Configurations:
- **Standard Genetic Algorithm (GA)**
  - Evaluation function of choice.
  - Crossover method of choice + random mutation.
- **GA with Clustering**
  - With evaluation function only.
  - With evaluation function + clustering (K-Means, Hierarchical, DBSCAN).

### Benchmark Functions:
- **Unimodal Function:** Sphere Function
- **Multimodal Function:** Schwefel Function

### Statistical Analysis:
- ANOVA and Tukey HSD Test were used to verify whether differences in performance are statistically significant.

## 📊 Results

The results include:
- Performance comparison across different algorithm configurations.
- Evaluation of diversity maintenance effectiveness.
- Statistical significance testing results.

## 📜 License
This project is for academic purposes under the Applied Evolutionary Computation course at UFMA.

## 👨‍🏫 Author
- José Brito – Master's Student in Computer Science at UFMA
- Instructor: Prof. Omar Andres Carmona Cortes

