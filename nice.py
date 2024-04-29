# silence warnings
import warnings
warnings.filterwarnings('ignore')

import pandas as pd
import pyfolio as pf
%matplotlib inline

class Strategy:
    
    def __init__(self, name=None):
        self.name = name
        
    def __repr__(self):
        if self.name is not None:
            return self.name
        else:
            return 'Unnamed strategy'

    # datetime-index column, security-return column, signal
    # trading_decision(signal, existing_position=None)
    def backtest(self, data, trading_decision_function):
        positions = []
        existing_position = 0
        for index, row in history.iterrows():
            new_position = trading_decision_function(row['signal'], existing_position)
            positions.append(new_position)
            existing_position = new_position
        history['position'] = positions
        history['strategy-return'] = history['position'] * history['security-return']
        
        pf.create_returns_tear_sheet(history['strategy-return'])
        return history

history = pd.read_csv('meta.csv', index_col='Date')
history.index = pd.to_datetime(history.index, utc=True)
history['security-return'] = history.Close.pct_change()
history['signal'] = (history['Low'] + history['High']) / history['Open']

def trading_func(signal, existing_position):
    return max(min(0.1 * signal, 0.5), -0.5)

b = Strategy()
df = b.backtest(history, trading_func)
