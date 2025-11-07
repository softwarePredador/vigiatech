# VIGIATECH - Documentação do Projeto

## 📋 Visão Geral

VIGIATECH é um aplicativo móvel de monitoramento industrial IoT desenvolvido em Flutter. Serve como interface principal para uma plataforma de manutenção preditiva, permitindo monitorar continuamente dados vitais de máquinas industriais (como vibração) e alertando operadores sobre anomalias antes que ocorra uma falha catastrófica.

## 🎯 Problema que Resolve

Redução do tempo de inatividade de máquinas industriais através do monitoramento contínuo e alertas preditivos.

## 🔄 Como Funciona

1. **Hardware**: Sensores VIGIATECH são instalados nas máquinas
2. **Provisionamento**: Técnico usa o app para conectar sensor via Bluetooth e fornecer credenciais Wi-Fi
3. **Monitoramento**: Sensor envia dados em tempo real para a nuvem
4. **Visualização**: App exibe dados, status e envia notificações push

## 🎨 Identidade Visual

### Paleta de Cores

| Cor | Código HEX | Uso no App |
|-----|-----------|-----------|
| Azul-escuro industrial | `#24324F` | Fundo principal (dark mode) |
| Cinza-escuro neutro | `#1A1F2C` | Navegação, painéis, campos de input |
| Branco gelo | `#E6F7F4` | Textos principais, títulos, labels |
| Verde-claro tecnológico | `#ADFBED` | Botões primários, status "Normal" |
| Azul-claro vibrante | `#3DB3C7` | Tags "Warning", ícones de alerta |
| Azul-ciano suave | `#6EE7E7` | Linhas de gráficos, ícones secundários |

## 🏗️ Arquitetura MVP

### Estrutura de Pastas

```
lib/
├── core/                          # Núcleo da aplicação
│   ├── constants/                 # Constantes da aplicação
│   │   ├── app_colors.dart       # Paleta de cores
│   │   ├── app_routes.dart       # Rotas de navegação
│   │   └── app_strings.dart      # Strings constantes
│   ├── theme/                     # Configuração de tema
│   │   └── app_theme.dart        # Tema dark mode
│   └── utils/                     # Utilitários (futuro)
│
├── models/                        # Modelos de dados
│   ├── machine.dart              # Modelo de máquina
│   ├── alert.dart                # Modelo de alerta
│   └── user.dart                 # Modelo de usuário
│
├── views/                         # Camada de visualização (UI)
│   ├── auth/                     # Telas de autenticação
│   │   ├── login_view.dart
│   │   └── forgot_password_view.dart
│   ├── devices/                  # Telas de dispositivos
│   │   ├── devices_view.dart
│   │   ├── machine_details_view.dart
│   │   └── add_device_view.dart
│   └── alerts/                   # Telas de alertas
│       ├── alerts_view.dart
│       └── settings_view.dart
│
├── presenters/                    # Camada de apresentação (Lógica)
│   ├── auth/
│   │   └── auth_presenter.dart
│   ├── devices/
│   │   └── devices_presenter.dart
│   └── alerts/
│       └── alerts_presenter.dart
│
├── widgets/                       # Widgets reutilizáveis
│   └── common/
│
└── main.dart                      # Ponto de entrada
```

## 🗺️ Roadmap Implementado

### Fase 1: Autenticação ✅
**Objetivo**: Portal seguro para usuários

**Telas**:
- ✅ Login (`login_view.dart`)
  - Campos: Email, Senha
  - Validação de formulário
  - Navegação para recuperação de senha
  - Tema: Fundo #24324F, botão #ADFBED

- ✅ Esqueci Minha Senha (`forgot_password_view.dart`)
  - Campo: Email
  - Envio de link de recuperação
  - Mensagem de sucesso
  - Link: Cor #3DB3C7

**Próximos Passos**:
- [ ] Integração Firebase Auth
- [ ] Gerenciamento de sessão
- [ ] Tokens de autenticação

### Fase 2: Provisionamento de Dispositivos ✅
**Objetivo**: Configurar sensores na rede Wi-Fi

**Telas**:
- ✅ Adicionar Dispositivo (`add_device_view.dart`)
  - Scan Bluetooth (BLE) por dispositivos
  - Seleção de dispositivo
  - Configuração Wi-Fi (SSID/Senha)
  - Feedback de sucesso/falha
  - Tema: Ícone Bluetooth #6EE7E7

**Próximos Passos**:
- [ ] Implementar flutter_blue_plus para BLE
- [ ] Protocolo de comunicação com sensor
- [ ] Validação de conectividade

### Fase 3: Dashboard e Monitoramento ✅
**Objetivo**: Visualizar status de máquinas

**Telas**:
- ✅ Lista de Dispositivos (`devices_view.dart`)
  - Lista de máquinas com status
  - Ícones de status:
    - Normal (✔️): #ADFBED
    - Warning (⚠️): #3DB3C7
  - Bottom Navigation Bar
  - Pull-to-refresh

- ✅ Detalhes da Máquina (`machine_details_view.dart`)
  - Tag de status (Warning: #3DB3C7)
  - Gráfico histórico (linha: #6EE7E7)
  - Informações da máquina
  - Nível de vibração
  - Última atualização

**Próximos Passos**:
- [ ] Integração com backend/API
- [ ] Dados em tempo real (WebSocket)
- [ ] Biblioteca de gráficos (fl_chart)
- [ ] Cache local de dados

### Fase 4: Alertas e Configurações ✅
**Objetivo**: Notificar usuários e gerenciar app

**Telas**:
- ✅ Alertas (`alerts_view.dart`)
  - Lista de alertas recentes
  - Ícones de alerta: #3DB3C7
  - Timestamp ("2m ago")
  - Indicador de não lido

- ✅ Configurações (`settings_view.dart`)
  - Opções: Conta, Notificações
  - Botão de logout
  - Separadores e setas: #E6F7F4 ou #6EE7E7

**Próximos Passos**:
- [ ] Firebase Cloud Messaging (FCM)
- [ ] Push notifications
- [ ] Gerenciamento de preferências
- [ ] Telas de submenu (Account, Notifications)

## 📊 Modelos de Dados

### Machine (Máquina)
```dart
{
  id: String
  name: String
  status: MachineStatus (normal|warning|critical|offline)
  vibrationLevel: double
  lastUpdated: DateTime
  location: String?
  model: String?
}
```

### Alert (Alerta)
```dart
{
  id: String
  machineId: String
  machineName: String
  title: String
  message: String
  timestamp: DateTime
  isRead: bool
}
```

### User (Usuário)
```dart
{
  id: String
  email: String
  name: String
  profileImage: String?
}
```

## 🎯 Padrão MVP Explicado

### Model (Modelo)
- Representa os dados da aplicação
- Localização: `lib/models/`
- Responsabilidade: Estrutura de dados e serialização

### View (Visualização)
- Interface do usuário
- Localização: `lib/views/`
- Responsabilidade: Exibir dados e capturar interações

### Presenter (Apresentador)
- Lógica de negócios
- Localização: `lib/presenters/`
- Responsabilidade: Processar dados, comunicar com APIs, gerenciar estado

## 🚀 Próximos Passos de Desenvolvimento

### Curto Prazo
1. [ ] Adicionar gerenciamento de estado (Provider/Riverpod)
2. [ ] Implementar Firebase Authentication
3. [ ] Criar testes unitários e de widget
4. [ ] Adicionar validação de formulários robusta

### Médio Prazo
1. [ ] Integração com backend/API REST
2. [ ] Implementar Bluetooth Low Energy
3. [ ] Adicionar Firebase Cloud Messaging
4. [ ] Biblioteca de gráficos avançada

### Longo Prazo
1. [ ] WebSocket para dados em tempo real
2. [ ] Modo offline com sincronização
3. [ ] Analytics e crash reporting
4. [ ] CI/CD pipeline
5. [ ] Publicação nas stores (Google Play, App Store)

## 🧪 Testes

### Estrutura de Testes (A Implementar)
```
test/
├── unit/                          # Testes unitários
│   ├── models/
│   └── presenters/
├── widget/                        # Testes de widget
│   └── views/
└── integration/                   # Testes de integração
```

## 📦 Dependências Futuras

```yaml
dependencies:
  # Estado
  provider: ^6.0.0
  
  # Autenticação
  firebase_auth: ^4.0.0
  firebase_core: ^2.0.0
  
  # Notificações
  firebase_messaging: ^14.0.0
  
  # Bluetooth
  flutter_blue_plus: ^1.0.0
  
  # Gráficos
  fl_chart: ^0.60.0
  
  # HTTP
  http: ^1.0.0
  dio: ^5.0.0
  
  # Armazenamento local
  shared_preferences: ^2.0.0
  
  # Navegação
  go_router: ^10.0.0
```

## 📱 Telas do App

### Fase 1: Autenticação
1. **Login** - Ponto de entrada seguro
2. **Forgot Password** - Recuperação de senha

### Fase 2: Provisionamento
3. **Add Device** - Configuração de sensores

### Fase 3: Monitoramento
4. **Devices** - Lista de máquinas
5. **Machine Details** - Detalhes e gráficos

### Fase 4: Gestão
6. **Alerts** - Histórico de alertas
7. **Settings** - Configurações do app

## 🔒 Segurança

- [ ] Autenticação segura (Firebase Auth)
- [ ] Tokens JWT para API
- [ ] Criptografia de dados sensíveis
- [ ] HTTPS para todas comunicações
- [ ] Validação de entrada de usuário

## 📈 Métricas de Sucesso

- Tempo de resposta < 2s
- 99.9% de uptime
- Detecção de anomalias com 95% de precisão
- Redução de 30% em tempo de inatividade

## 👥 Equipe

- Desenvolvimento: Flutter/Dart
- Backend: (A definir)
- IoT/Hardware: Sensores VIGIATECH
- Design: UI/UX conforme paleta definida

---

**Versão**: 1.0.0  
**Última Atualização**: 2025  
**Status**: Em Desenvolvimento (MVP Estrutural Completo)