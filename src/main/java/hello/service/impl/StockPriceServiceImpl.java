package hello.service.impl;

import hello.config.StockConfig;
import hello.service.StockPriceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Random;

@Service
public class StockPriceServiceImpl implements StockPriceService {

    private StockConfig stockConfig;

    @Autowired
    public StockPriceServiceImpl(StockConfig stockConfig) {
        this.stockConfig = stockConfig;
    }

    @Override
    public int GetPrice(String symbol) {
        stockConfig.getProviderUrl();
        return new Random().nextInt(100 - 10 + 1) + 10;
    }
}
