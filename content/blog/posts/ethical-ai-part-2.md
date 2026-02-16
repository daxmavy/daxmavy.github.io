---
title: "Maths and ethics don't mix nicely: Ethical AI in business, part 2"
date: 2020-08-28
draft: true
---

## Racial bias in sentencing

A prominent case involves the COMPAS algorithm, used to predict recidivism for parole and sentencing decisions across the United States. ProRepublica reported that "There's software used across the country to predict future criminals. And it's biased against blacks." However, criminal justice researchers contested this finding, ultimately revealing that both parties were correct—they simply employed different evaluation metrics.

ProRepublica measured the false positive rate for Black individuals against the false negative rate for white individuals. In contrast, Northpointe (the algorithm developers) and researchers evaluated positive predictive value, which accounts for both false positives and negatives. Under this measure, both groups showed approximate equality.

The core tension is clear: allowing Black individuals to be wrongly incarcerated while releasing white individuals incorrectly raises significant justice concerns. Yet the solution proves elusive. Optimizing solely against false incarceration means the algorithm would rarely recommend detention. Additionally, empirical differences in recidivism rates between racial groups means identical metrics applied universally will always show disparities.

A fundamental question emerges: should algorithms participate in sentencing decisions at all?

## Ethics becomes quantifiable

Ethics discussions traditionally belong to the humanities, but AI systems make these considerations measurable and explicit—introducing both advantages and complications.

**Benefits:**
- Algorithms provide transparency impossible with human decision-makers
- Quantifiable discrimination measures through counterfactual testing and simulation
- Data-driven insights beyond theoretical frameworks

**Challenges:**
- Over 37 contradictory fairness definitions exist
- Narrow quantitative fairness conceptions may overlook human dimensions
- Unexplored populations absent from datasets remain invisible
- Risk of discovering discrimination selectively through extensive testing
