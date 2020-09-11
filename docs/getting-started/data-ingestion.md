# Ingest some data

Now that our `breakdown` model has been properly created, we can start to ingest some data to fill our model.

Let's generate and push some breakdown event.

To do so, we are doing to use the [Ingester API](/ingester/ingester) as our single and only entrypoint for data ingestion.

In a production context, we would use a proper standard or customized connector to read and extract data from the customer systems, and send the result data to the ingester API.

To make some quick testing, we will directly work with the ingester API (using either cURL or the associated swagger GUI) and send some example datas.

TODO:

```shell
curl -X POST -d '{""}' http://localhost:9002/api/v4/ingester/data
```
