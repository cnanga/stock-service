package hello.controller;

import hello.model.StockPrice;
import hello.service.StockPriceService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RestController
public class StockPriceController {

    private final static Logger LOGGER = LoggerFactory.getLogger(StockPriceController.class);

    @Autowired
    private StockPriceService stockPriceService;

    @ApiOperation(value = "Get stock price for the given stock symbol")
    @RequestMapping(method = RequestMethod.GET, value = "/stock")
    public StockPrice stockPrice(@RequestParam(value="ticker", defaultValue="MSFT") String name) {

        LOGGER.info("Here");

        return new StockPrice(stockPriceService.GetPrice(name), name);
    }
}
