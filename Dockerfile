FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

COPY InvoiceTracker.sln .
COPY InvoiceTracker.API/InvoiceTracker.API.csproj InvoiceTracker.API/

RUN dotnet restore

COPY . .

RUN dotnet publish InvoiceTracker.API/InvoiceTracker.API.csproj -c Release -o /out

FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /out .

EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

ENTRYPOINT ["dotnet", "InvoiceTracker.API.dll"]