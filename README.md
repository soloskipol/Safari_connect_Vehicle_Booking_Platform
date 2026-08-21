# Safari_connect-Bus-Booking-Platform

## Operations & Revenue Analysis

## Project Overview

## Project Overview

Safari Connect is an end-to-end data analytics project for a bus transportation company operating across Kenya. The project covers the full workflow from data loading and cleaning in PostgreSQL/pgAdmin to interactive analysis and visualization in Power BI.

The cleaned data is stored in PostgreSQL and connected to Power BI, allowing the Power BI report to be refreshed from the database when the underlying data is updated. The fully interactive dashboard uses slicers and visual interactions to explore revenue, route performance, driver performance, passenger patterns, cancellations, and operational activity.

The analysis is designed to provide actionable insights that can support revenue growth, operational planning, and management decision-making.

## Business Questions

The analysis answers the following questions:

- Which routes generate the most revenue, are most popular, and are most efficient per seat?
- Which drivers perform best, and who could be considered for promotion?
- How does revenue change over time?
- Where do passengers come from, which seat classes do they prefer, and what are their satisfaction patterns?
- How frequently do cancellations occur, which routes have the highest cancellation rates, and how much revenue is affected?
- What are the busiest days and departure times, and when should additional vehicles be considered?

## Tools Used

- **PostgreSQL / pgAdmin** – Data loading, cleaning, validation, and SQL analysis
- **Power BI** – Data visualization and interactive dashboard
- **SQL** – Data transformation and business analysis

## Data Cleaning

The dataset was cleaned and standardized in PostgreSQL. Key cleaning activities included:

- Standardizing passenger names, cities, genders, vehicle types, driver names, and booking statuses
- Cleaning and standardizing Kenyan phone numbers
- Standardizing seat class and payment method values
- Removing invalid negative seat values
- Validating duplicate booking IDs
- Cleaning invalid trip ratings and setting ratings for cancelled/no-show trips to NULL
- Converting fare data into appropriate numeric formats

## Dashboard

The Power BI dashboard consists of two pages:

### Page 1 – Executive Overview
Provides a high-level view of:
- Revenue and booking performance
- Revenue trends
- Route performance
- Driver performance
- Passenger distribution
- Cancellation performance

### Page 2 – Detailed Performance & Operations
Provides:
- Route performance matrix
- Driver performance matrix
- Passenger insights
- Trip rating distribution
- Day and departure-time operational analysis

## Interactive Dashboard

The Power BI report is fully interactive and dynamic. Users can use slicers and visual interactions to explore the data by:

- Date
- Route
- Vehicle Type
- Booking Status
- Day of Week

Selections made through the slicers dynamically update the dashboard visuals, KPIs, charts, and detailed matrices, allowing users to explore different aspects of the business.

## Key Insights

The dashboard enables management to identify:

- High- and low-performing routes
- Strong driver performers
- Revenue trends and changes over time
- Passenger demographics and preferences
- Routes with higher cancellation rates
- Peak operating periods requiring additional capacity


