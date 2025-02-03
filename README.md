# Inventory Management System

A simple inventory management system built with **Ruby on Rails** and **Hotwire (Turbo & Stimulus)** for real-time search and filtering.
A very simple approach was taken including in the UI, main thing being put into consideration is just to show the skills required!

## Assumption

This app is only for admins hence no need for th namespacing in the routes to show admins or dashbord

## Features

- Search products dynamically using **Turbo & Stimulus.js**
- Filter products by **price range**
- Sort products by **name, price, or quantity**
- Auto-submit search form with **debounced input**
- Fully tested with **Minitest**

### How to test hotwire interactivity

Create a product which the stock quantity is 10 or less and go to the show page a pop up will show the hotwire flash message and then it is also wiped out after thirty seconds.

## Setup Instructions

### Prerequisites

Ensure you have:

- Ruby 3.x
- Rails 7.x
- PostgreSQL

### Installation

Clone the repository and install dependencies:

```sh
git clone https://github.com/mwaurajr/inventory-system
cd inventory_management
bundle install
rails db:setup

```
