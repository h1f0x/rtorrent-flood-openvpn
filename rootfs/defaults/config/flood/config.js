const CONFIG = {
  baseURI: process.env.FLOOD_BASE_URI || '/',
  dbCleanInterval: 1000 * 60 * 60,
  dbPath: '/config/flood/db/',
  floodServerHost: '127.0.0.1',
  torrentClientPollInterval: 1000 * 2,
  floodServerPort: 3000,
  maxHistoryStates: 30,
  pollInterval: 1000 * 5,
  secret: 'flood',
  scgi: {
    host: '127.0.0.1',
    port: 5000,
    socket: true,
    socketPath: '/config/rtorrent/session/rpc.socket'
  },
  ssl: false,
  sslKey: '/config/flood/flood_ssl.key',
  sslCert: '/config/flood/flood_ssl.cert'
};

module.exports = CONFIG;