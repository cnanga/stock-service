package hello.model;

public class StockPrice {

    private final long price;
    private final String symbol;

    public StockPrice(long id, String content) {
        this.price = id;
        this.symbol = content;
    }

    public long getPrice() {
        return price;
    }

    public String getSymbol() {
        return symbol;
    }
}
