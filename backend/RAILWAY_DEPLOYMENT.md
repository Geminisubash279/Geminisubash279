# 🚀 Railway Deployment Guide

## ✅ What's New (Railway-Ready Updates)

Your server.js has been updated to be fully compatible with Railway.com deployment:

### 1. **Health Check Endpoints**
- `GET /health` - Server health status
- `GET /db-status` - Database connection status

### 2. **Graceful Shutdown**
- Handles SIGTERM and SIGINT signals properly
- Closes database connections before exiting
- Essential for Railway's rolling updates

### 3. **Improved Database Connection**
- Retry logic with 5-second intervals
- Connection timeout and request timeout set to 30 seconds
- Better error logging and monitoring

### 4. **Environment Variable Support**
All sensitive data now uses environment variables:
- `DB_USER`, `DB_PASSWORD`, `DB_SERVER`, `DB_NAME`, `DB_PORT`
- `PORT` (Railway sets this automatically)
- `NODE_ENV`

---

## 📋 Pre-Deployment Checklist

### Step 1: Prepare Your Repository
```bash
# Ensure you have the latest code committed
git add .
git commit -m "Update server for Railway deployment"
git push origin main
```

### Step 2: Create a Railway Project
1. Go to [Railway.app](https://railway.app)
2. Click "New Project"
3. Choose "Deploy from GitHub"
4. Select your repository

### Step 3: Configure Environment Variables
In Railway Dashboard:
1. Go to your project
2. Click "Add Service" → "Database" → "MySQL" or your database provider
3. Click "Add Service" → "GitHub Repo" (your project)
4. In the GitHub service, go to "Variables" tab
5. Add the following variables:

```
PORT=3000
NODE_ENV=production
DB_USER=db_ac6cf3_gstscheme_admin
DB_PASSWORD=Gst@2026
DB_SERVER=sql5111.site4now.net
DB_NAME=db_ac6cf3_gstscheme
DB_PORT=1433
```

### Step 4: Deploy
1. Railway will automatically detect `railway.json`
2. Deployment starts automatically on git push
3. Monitor logs in the Railway dashboard

---

## 🔍 Verification

After deployment, test these endpoints:

### Health Check
```bash
curl https://your-railway-url.railway.app/health
```

Response:
```json
{
  "status": "✅ Server is running",
  "timestamp": "2024-04-25T10:30:45.123Z",
  "environment": "production"
}
```

### Database Status
```bash
curl https://your-railway-url.railway.app/db-status
```

Response:
```json
{
  "status": "✅ Database connected",
  "test": [{ "test": 1 }],
  "timestamp": "2024-04-25T10:30:45.123Z"
}
```

---

## 📊 Monitoring

### View Logs
1. Go to Railway dashboard
2. Select your service
3. Click "Logs" tab
4. Look for:
   - `✅ Database connected successfully`
   - `✅ SERVER STARTED SUCCESSFULLY`
   - Any error messages starting with `❌`

### Performance Tips
- Monitor database connection errors
- Check response times via Railway metrics
- Scale vertically if needed (Railway → Settings → Compute)

---

## 🐛 Troubleshooting

### Database Connection Failed
```
❌ Database connection failed: ...
⚠️ Retrying database connection in 5 seconds...
```

**Solution:** 
- Verify DB credentials in Variables
- Check if database server is accessible from Railway
- Ensure DB_SERVER and DB_PORT are correct

### Port Issues
```
Error: listen EADDRINUSE :::3000
```

**Solution:**
- Railway automatically sets PORT env variable
- Server already listens on `0.0.0.0:${PORT}`
- No changes needed

### Service Not Starting
1. Check "Logs" for error messages
2. Verify `package.json` has `"start": "node server.js"`
3. Confirm `railway.json` exists and is valid
4. Check for syntax errors in `server.js`

---

## 🔐 Security

### Best Practices
✅ Use environment variables for all secrets
✅ Never commit `.env` file (use `.env.example`)
✅ Add `node_modules/` to `.gitignore`
✅ Keep dependencies updated

### Secrets Management
1. Create sensitive variables in Railway
2. Never log sensitive data (DB passwords, API keys)
3. Use HTTPS only (Railway enforces this)
4. Rotate API keys regularly

---

## 📦 Package.json Check

Your `package.json` should have:

```json
{
  "name": "gs-thanga-maligai-server",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "engines": {
    "node": ">=18.0.0"
  },
  "dependencies": {
    "express": "^5.2.1",
    "mssql": "^12.2.0",
    "cors": "^2.8.6",
    "axios": "^1.13.6",
    "razorpay": "^2.9.6"
  }
}
```

---

## 🎯 Next Steps

1. ✅ Commit all changes to git
2. ✅ Push to GitHub
3. ✅ Create Railway project and link GitHub repo
4. ✅ Add environment variables
5. ✅ Deploy
6. ✅ Test endpoints
7. ✅ Update client config to point to new URL

---

## 📞 Support

- [Railway Documentation](https://docs.railway.app/)
- [Railway Discord Community](https://discord.gg/railway)
- Check server logs for detailed error messages

---

**Last Updated:** April 25, 2026
**Server Version:** Railway-Ready v1.1
