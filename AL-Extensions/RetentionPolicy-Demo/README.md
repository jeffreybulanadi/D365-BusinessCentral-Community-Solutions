# Business Central Retention Policy Demo

A practical demonstration of how to implement and use retention policies in Business Central to automatically clean up old data.

## Overview

This demo shows the complete process of setting up retention policies for custom tables. You'll learn how to register tables with the retention policy framework and see automated data cleanup in action.

## What You'll Learn

- How to make custom tables eligible for retention policies
- How to create demo data for testing retention policies
- How to configure retention policies through the Business Central UI
- How automatic data cleanup works based on date fields

## Demo Process Flow

### 1. Install the Extension
- The extension automatically registers the Demo Transaction table for retention policies during installation
- No manual setup required - everything is configured automatically

### 2. Create Demo Data
Open the **Demo Transactions** page and use these actions:

**Create Sample Data:**
- Creates 10 recent transactions (last 30 days)
- Uses random dates within the current month
- All marked as "Processed" status

**Create Old Data:**
- Creates 20 historical transactions (3-5 years old)
- All marked as "Archived" status
- These are the records that will be targeted by retention policies

### 3. Setup Retention Policy
**Setup Retention Policy:**
- Registers the Demo Transaction table with the retention policy framework
- Makes the table available for policy configuration

**Open Retention Policies:**
- Opens the standard Business Central retention policy configuration page
- Here you can create and manage retention policies

### 4. Configure the Policy
In the Retention Policies page:
1. Create a new retention policy
2. Select "Demo Transaction" as the table
3. Set retention period (e.g., 2 years)
4. Configure filters if needed (e.g., only archived records)
5. Enable the policy

### 5. Test the Policy
- Run the retention policy manually or wait for automatic execution
- Old transactions (3-5 years) will be automatically deleted
- Recent transactions (last 30 days) will remain

## Technical Implementation

### Key Components

**Demo Transaction Table:**
- Simple transaction table with essential fields
- `Transaction Date` field is used by retention policies to determine record age
- `Status` field allows filtering (e.g., only delete archived records)
- Uses `GetNextEntryNo()` for proper entry numbering

**Demo Data Management:**
- `CreateSampleTransactions()` - Creates current period data
- `CreateOldTransactions()` - Creates historical data for testing
- Both methods use realistic date ranges and proper sequencing

**Retention Policy Setup:**
- `SetupDemoRetentionPolicies()` - Registers table with retention framework
- Uses `RetenPolAllowedTables.AddAllowedTable()` to enable retention policies

**Install Codeunit:**
- Automatically runs setup when extension is installed
- Ensures retention policy is configured without manual intervention

### Code Flow

1. **Installation:** `DemoInstall.OnInstallAppPerCompany()` → `SetupDemoRetentionPolicies()`
2. **Data Creation:** Page actions → `DemoDataManagement.CreateSampleTransactions()` / `CreateOldTransactions()`
3. **Policy Configuration:** Manual setup in Business Central Retention Policies page
4. **Automatic Cleanup:** Business Central job queue executes retention policies daily

## Files Structure

```
src/
├── table/
│   └── DemoTransaction.Table.al          # Main demo table
├── page/
│   └── DemoTransactions.Page.al          # List page with demo actions
├── codeunit/
│   ├── DemoDataManagement.Codeunit.al    # Data creation logic
│   ├── DemoRetentionPolicySetup.Codeunit.al  # Policy registration
│   └── DemoInstall.Codeunit.al           # Auto-setup on install
├── enum/
│   ├── DemoTransactionType.Enum.al       # Transaction types
│   └── DemoTransactionStatus.Enum.al     # Status values
└── permissionset/
    └── RetentionPolicy.PermissionSet.al  # Required permissions
```

## Demo Script (5 Minutes)

1. **Show empty Demo Transactions page** (30 seconds)
2. **Create sample data** - both current and old (1 minute)
3. **Setup retention policy** via button click (30 seconds)
4. **Configure policy** in BC UI - 2 year retention (2 minutes)
5. **Run policy and verify** old data is deleted (1 minute)

## Key Benefits

- **Data Governance:** Automatic cleanup of old records
- **Storage Optimization:** Reduces database size over time
- **Compliance:** Configurable retention periods for regulatory requirements
- **Audit Trail:** Built-in logging of retention policy execution
- **Easy Implementation:** Simple AL code to register any custom table

## Production Usage

- Retention policies run automatically daily at 2 AM
- Can be customized to run at different intervals
- Supports complex filtering for conditional retention
- Provides detailed logs for audit and compliance
- Can be applied to any table with appropriate date fields

This demo provides a complete, practical example of implementing retention policies in your own Business Central extensions.
