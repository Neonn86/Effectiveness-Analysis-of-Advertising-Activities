# Effectiveness Analysis of Advertising Activities
## Objective
- Determine the effectiveness of online & offline advertising activities on the sales of a product for a cosmetics firm.
- Analyze potential reasons behind the result.
- Provides recommendations that help better determine advertising effectiveness.
## Problem Formulation
The cosmetics firm has employed both offline and online media channels.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/98130185/160251693-c4e7fd53-a76a-4160-98a2-263a62bd325f.png">

## Model Developement
### Feature Selection
Limited our analysis to 'Catalog Winback', 'Portals' and 'Newsletter'.
- Catalog Winback and Catalog NewCust primarily focus on brand awareness, but we only include Catalog Winback because the customer composition of ‘New
Customers’ is unclear.
- Choose 'Portal'. 'Search', 'Portals', and 'Retargeting' are highly correlated. Drop 'Search', 'Retargeting' because Portals is a closer touchpoint to Sales and the firm invested in retargeting only in later times.
- Newsletter is powerful in the consideration stage because it advertises the product specifically to the customers, and any click-through leads to the customers landing on the purchase page.


### Model 1 - Basic
 Basic model focuses on the individual effects of the media and does not incorporate advertising synergy.
 - **To capture the diminishing returns of advertising spend, a square root transformation is applied.**
 - **To account for carryover effect of advertising, a lag in sales is incorporated.**

<img width="500" alt="image" src="https://user-images.githubusercontent.com/98130185/160252437-35bd9451-2f98-47b5-ba21-32da410a3202.png">

<img width="500" alt="Screen Shot 2022-03-26 at 11 29 50 AM" src="https://user-images.githubusercontent.com/98130185/160252563-b541aefa-f282-4a73-a089-19f1c45eb73d.png">

- Under 95% confidence, Catalog Winback, Newsletter, Portals can explain 27.1% change of sales in the last 42 months with statistical significance.

<img width="325" alt="Screen Shot 2022-03-26 at 11 31 42 AM" src="https://user-images.githubusercontent.com/98130185/160252633-bd65fcf8-20ca-4754-9b99-ad3bc7d007c1.png">

- Portals advertisement is the channel with the highest return on advertising investment. With 10% increase spending on the Portals, the sales would
increase by 1.8%.

### Model 2 - Experimenting with online-online synergy

<img width="500" alt="Screen Shot 2022-03-26 at 11 51 22 AM" src="https://user-images.githubusercontent.com/98130185/160253204-4628bac0-cadd-422d-abcf-f026e1f880f7.png">


### Model 3 - Experimenting with offline-online synergy
<img width="500" alt="Screen Shot 2022-03-26 at 11 51 50 AM" src="https://user-images.githubusercontent.com/98130185/160253221-df0ff608-65e3-491d-a9fe-b1e86c33aee7.png">

### Model 4 - Experimenting with offline-online & online-online synergy
<img width="500" alt="Screen Shot 2022-03-26 at 11 52 05 AM" src="https://user-images.githubusercontent.com/98130185/160253229-d4990fc5-e463-4cc8-98db-22ab46318d12.png">

## Conclusion
