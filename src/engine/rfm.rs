//! RFM (Recency-Frequency-Monetary) calculation engine

use crate::Result;

/// Decay function for RFM weighting
#[derive(Clone, Debug, Copy)]
pub enum DecayFunction {
    Linear,
    Exponential,
    Inverse,
}

impl std::fmt::Display for DecayFunction {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            DecayFunction::Linear => write!(f, "linear"),
            DecayFunction::Exponential => write!(f, "exponential"),
            DecayFunction::Inverse => write!(f, "inverse"),
        }
    }
}

/// RFM configuration
#[derive(Clone, Debug)]
pub struct RFMConfig {
    pub recency_window_days: u32,
    pub frequency_threshold: usize,
    pub monetary_threshold: f64,
    pub decay_function: DecayFunction,
    pub decay_half_life_days: u32,
}

impl Default for RFMConfig {
    fn default() -> Self {
        Self {
            recency_window_days: 90,
            frequency_threshold: 1,
            monetary_threshold: 0.0,
            decay_function: DecayFunction::Linear,
            decay_half_life_days: 30,
        }
    }
}

/// RFM score for a single customer
#[derive(Clone, Debug)]
pub struct RFMScore {
    pub customer_id: String,
    pub recency: f64,
    pub frequency: f64,
    pub monetary: f64,
}

/// Calculate RFM scores
pub fn calculate_rfm(
    _transactions: Vec<Transaction>,
    _config: &RFMConfig,
) -> Result<Vec<RFMScore>> {
    // TODO: Implement RFM calculation
    Ok(vec![])
}

/// Apply decay function to scores
pub fn apply_decay(_scores: Vec<RFMScore>, _decay: DecayFunction) -> Result<Vec<RFMScore>> {
    // TODO: Implement decay application
    Ok(vec![])
}

/// Normalize RFM scores to [0, 1]
pub fn normalize_rfm(scores: &mut [RFMScore]) -> Result<()> {
    if scores.is_empty() {
        return Ok(());
    }

    // TODO: Implement normalization
    Ok(())
}

/// Transaction data
#[derive(Clone, Debug)]
pub struct Transaction {
    pub customer_id: String,
    pub date: String, // ISO 8601 date string
    pub amount: f64,
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_decay_function_display() {
        assert_eq!(DecayFunction::Linear.to_string(), "linear");
        assert_eq!(DecayFunction::Exponential.to_string(), "exponential");
        assert_eq!(DecayFunction::Inverse.to_string(), "inverse");
    }

    #[test]
    fn test_rfm_config_default() {
        let config = RFMConfig::default();
        assert_eq!(config.recency_window_days, 90);
        assert_eq!(config.frequency_threshold, 1);
    }
}
